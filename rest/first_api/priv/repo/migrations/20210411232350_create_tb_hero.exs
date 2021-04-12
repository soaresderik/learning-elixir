defmodule FirstApi.Repo.Migrations.CreateTbHero do
  use Ecto.Migration

  def change do
    create table(:tb_hero) do
      add :first_name, :string
      add :last_name, :string
      add :nick_name, :string

      timestamps()
    end

  end
end
