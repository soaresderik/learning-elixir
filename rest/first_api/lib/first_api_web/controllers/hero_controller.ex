defmodule FirstApiWeb.HeroController do
  use FirstApiWeb, :controller

  alias FirstApi.Heros
  alias FirstApi.Heros.Hero

  action_fallback FirstApiWeb.FallbackController

  def index(conn, _params) do
    tb_hero = Heros.list_tb_hero()
    render(conn, "index.json", tb_hero: tb_hero)
  end

  def create(conn, %{"hero" => hero_params}) do
    with {:ok, %Hero{} = hero} <- Heros.create_hero(hero_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.hero_path(conn, :show, hero))
      |> render("show.json", hero: hero)
    end
  end

  def show(conn, %{"id" => id}) do
    hero = Heros.get_hero!(id)
    render(conn, "show.json", hero: hero)
  end

  def update(conn, %{"id" => id, "hero" => hero_params}) do
    hero = Heros.get_hero!(id)

    with {:ok, %Hero{} = hero} <- Heros.update_hero(hero, hero_params) do
      render(conn, "show.json", hero: hero)
    end
  end

  def delete(conn, %{"id" => id}) do
    hero = Heros.get_hero!(id)

    with {:ok, %Hero{}} <- Heros.delete_hero(hero) do
      send_resp(conn, :no_content, "")
    end
  end
end
