defmodule SecretGrinch.User do
  @moduledoc """
  Represents a user of the system
  """
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password))
    |> validate_length(:password, min: 6, max: 100)
  end

  @doc false
  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, ~w(name email))
    |> validate_length(:name, min: 1, max: 20)
  end
end
