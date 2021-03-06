defmodule RumblWeb.SessionController do
  use RumblWeb, :controller
  alias Rumbl.Repo

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" => pass}}) do
    case Rumbl.Auth.login_by_username_and_pass(conn, user, pass, repo: Repo) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Bem vindo de volta!")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Senha/Usuário inválido.")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Rumbl.Auth.logout
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
