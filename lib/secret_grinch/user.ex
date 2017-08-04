defmodule SecretGrinch.User do
  @moduledoc """
  Represents a user of the system
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias SecretGrinch.User


  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
  end
end
