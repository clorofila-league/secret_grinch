defmodule SecretGrinchWeb.MessageController do
  use SecretGrinchWeb, :controller
  plug :authenticate_user when action in [:index, :new, :show, :edit]
  alias SecretGrinch.Repo
  alias SecretGrinch.Message

  def new(conn, %{"match_id" => match_id}) do
    render conn, "new.html", match_id: match_id
  end

  def create(conn, %{"message" => message_params, "match_id" => match_id}) do
    {match_id, _} = Integer.parse(match_id)
    changeset =
      Message.changeset(%Message{}, message_params)
      |> Message.put_match_id(match_id)
      |> Message.put_sender_id(conn.assigns.current_user.id)

    case Repo.insert(changeset) do
      {:ok, _message} ->
        conn
        |> put_flash(:info, "Message saved")
        |> redirect(to: match_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
