defmodule SecretGrinchWeb.SessionController do
  use SecretGrinchWeb, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"email" => email, "password" => pass}}) do
    case SecretGrinchWeb.Auth.login_by_email_and_pass(conn, email, pass, repo: SecretGrinch.Repo) do
    {:ok, conn} ->
      conn
      |> put_flash(:info, "Welcome back!")
      |> redirect(to: page_path(conn, :index))
    {:error, _reason, conn} ->
      conn
      |> put_flash(:error, "Invalid name/password combination")
      |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> SecretGrinchWeb.Auth.logout()
    |> redirect(to: page_path(conn, :index))
  end
end
