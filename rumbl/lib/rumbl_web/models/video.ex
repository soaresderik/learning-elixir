defmodule Rumbl.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Video

  @primary_key {:id, Rumbl.Permalink, autogenerate: true}
  schema "videos" do
    field :description, :string
    field :title, :string
    field :url, :string
    field :slug, :string
    belongs_to :user, Rumbl.User
    belongs_to :category, Rumbl.Category

    timestamps()
  end

  @doc false
  def changeset(%Video{} = video, attrs \\ %{}) do
    video
      |> cast(attrs, [:url, :title, :description, :category_id])
      |> slugify_title
      |> assoc_constraint(:category)
      |> validate_required([:url, :title, :description])
  end

  defp slugify_title(changeset) do
    if title = get_change(changeset, :title) do
      put_change(changeset, :slug, slugify(title))
    else
      changeset
    end
  end

  defp slugify(str) do
    str
    |> String.downcase()
    |> String.replace(~r/[^\w-]+/u, "-")
  end
end
