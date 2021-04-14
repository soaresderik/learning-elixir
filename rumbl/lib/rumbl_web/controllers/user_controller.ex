defmodule RumblWeb.UserController do
  use RumblWeb, :controller
  alias Rumbl.Repo
  alias Rumbl.User

  plug :authenticate when action in [:index, :show]


  def index(conn, _params) do
    users = Repo.all(Rumbl.User)
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(Rumbl.User, String.to_integer id)
    render conn, "show.html", user: user
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render conn, "new.html", changeset: changeset
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.registration_changeset(%User{}, user_params)
    IO.inspect changeset
    case Repo.insert(changeset) do
     {:ok, user} ->
        conn
          |> Rumbl.Auth.login(user)
          |> put_flash(:info, "#{user.name} criado com sucesso!")
          |> redirect(to: Routes.user_path(conn, :index))
     {:error, changeset } ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "Você precisa estar logado para acessar a página")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt
    end
  end
end
