defmodule SecretGrinchWeb.MatchControllerTest do
  use SecretGrinchWeb.ConnCase

  alias SecretGrinch.Matches

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:match) do
    {:ok, match} = Matches.create_match(@create_attrs)
    match
  end

  describe "index" do
    test "lists all matches", %{conn: conn} do
      conn = get conn, match_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Matches"
    end
  end

  describe "new match" do
    test "renders form", %{conn: conn} do
      conn = get conn, match_path(conn, :new)
      assert html_response(conn, 200) =~ "New Match"
    end
  end

  describe "create match" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, match_path(conn, :create), match: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == match_path(conn, :show, id)

      conn = get conn, match_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Match"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, match_path(conn, :create), match: @invalid_attrs
      assert html_response(conn, 200) =~ "New Match"
    end
  end

  describe "edit match" do
    setup [:create_match]

    test "renders form for editing chosen match", %{conn: conn, match: match} do
      conn = get conn, match_path(conn, :edit, match)
      assert html_response(conn, 200) =~ "Edit Match"
    end
  end

  describe "update match" do
    setup [:create_match]

    test "redirects when data is valid", %{conn: conn, match: match} do
      conn = put conn, match_path(conn, :update, match), match: @update_attrs
      assert redirected_to(conn) == match_path(conn, :show, match)

      conn = get conn, match_path(conn, :show, match)
      assert html_response(conn, 200) =~ "some updated name"
    end

    test "renders errors when data is invalid", %{conn: conn, match: match} do
      conn = put conn, match_path(conn, :update, match), match: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Match"
    end
  end

  describe "delete match" do
    setup [:create_match]

    test "deletes chosen match", %{conn: conn, match: match} do
      conn = delete conn, match_path(conn, :delete, match)
      assert redirected_to(conn) == match_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, match_path(conn, :show, match)
      end
    end
  end

  defp create_match(_) do
    match = fixture(:match)
    {:ok, match: match}
  end
end
