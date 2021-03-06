defmodule SecretGrinchWeb.MatchController do
  use SecretGrinchWeb, :controller

  alias SecretGrinch.Matches
  alias SecretGrinch.Matches.Match
  alias SecretGrinch.Repo

  plug :authenticate_user when action in [:index, :new, :show, :edit]

  def index(conn, _params) do
    matches = Matches.list_matches_for_user(conn.assigns.current_user)
    matches_to_subscribe = Matches.list_matches_for_user_to_subscribe(conn.assigns.current_user)
    render(conn, "index.html", matches: matches, matches_to_subscribe: matches_to_subscribe)
  end

  def new(conn, _params) do
    changeset = Matches.change_match(%Match{})
    {{year, month, day}, {h, m, _}} = :calendar.universal_time
    render(conn, "new.html", [changeset: changeset, action: :create, current_year: year, current_month: month, current_day: day, current_hours: h, current_minutes: m])
  end

  def create(conn, %{"match" => match_params}) do
    match_params = Map.put(match_params, "organizer_id", conn.assigns.current_user.id)
    result =
      %Match{}
      |> Match.changeset(match_params)
      |> Ecto.Changeset.put_assoc(:users, [conn.assigns.current_user])
      |> Repo.insert()

    case result do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match created successfully.")
        |> redirect(to: match_path(conn, :show, match))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    match = Matches.get_match!(id)
    render(conn, "show.html", match: match)
  end

  def edit(conn, %{"id" => id}) do
    match = Matches.get_match!(id)
    changeset = Matches.change_match(match)
    render(conn, "edit.html", match: match, changeset: changeset)
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Matches.get_match!(id)

    case Matches.update_match(match, match_params) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Match updated successfully.")
        |> redirect(to: match_path(conn, :show, match))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", match: match, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    match = Matches.get_match!(id)
    {:ok, _match} = Matches.delete_match(match)

    conn
    |> put_flash(:info, "Match deleted successfully.")
    |> redirect(to: match_path(conn, :index))
  end
end
