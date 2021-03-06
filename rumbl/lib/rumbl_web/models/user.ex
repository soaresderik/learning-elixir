defmodule Rumbl.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.User

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :videos, Rumbl.Video
    has_many :annotations, Rumbl.Annotation

    timestamps()
  end

  def changeset(%User{} = model, params \\ %{}) do
    model
    |> cast(params, [:username, :name])
    |> validate_required([:username, :name])
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:username)
  end

  def registration_changeset(%User{} = model, params) do
    model
    |> changeset(params)
    |> cast(params, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 6, max: 36)
    |> put_pass_hash
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ -> changeset
    end
  end
end
