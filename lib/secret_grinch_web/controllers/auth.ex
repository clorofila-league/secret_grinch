defmodule SecretGrinchWeb.Auth do
  import Plug.Conn

  def init(opts) do
    Keyword.fetch!(opts, :repo)
  end

  def call(conn, repo) do
    user_id = get_session(conn, :user_id)
    user = user_id && repo.get(SecretGrinch.User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def login_by_name_and_pass(conn, name, given_pass, opts) do
    repo = Keyword.fetch!(opts, :repo)
    user = repo.get_by(SecretGrinch.User, name: name)
    cond do
      user && checkpw(given_pass, user.password) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
        true ->
          # dummy_checkpw() // TODO
          {:error, :not_found, conn}
    end
  end

  defp checkpw(given_pass, password) do
    given_pass == password
  end
end
