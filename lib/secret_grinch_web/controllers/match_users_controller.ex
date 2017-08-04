defmodule SecretGrinchWeb.MatchUsersController do
  use SecretGrinchWeb, :controller
  plug :authenticate_user when action in [:create]
  alias SecretGrinch.Repo
  alias SecretGrinch.Matches

  def new(conn, %{"match_id" => match_id}) do
    render conn, "new.html", match_id: match_id
  end

  def create(conn, %{"match_id" => match_id}) do
    {match_id, _} = Integer.parse(match_id)
    match =
        SecretGrinch.Matches.Match
        |> Repo.get!(match_id)
        |> Repo.preload([:users])
    changeset =
      match
      |> Matches.change_match
      |> Ecto.Changeset.put_assoc(:users, [conn.assigns.current_user | match.users])

    case Repo.update(changeset) do
      {:ok, _match} ->
        conn
        |> put_flash(:info, "User added")
        |> redirect(to: match_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
