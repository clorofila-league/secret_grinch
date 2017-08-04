defmodule SecretGrinch.Matches.Match do
  @moduledoc """
  Represents a match of the system
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias SecretGrinch.Matches.Match

  schema "matches" do
    field :end_date, :naive_datetime
    field :name, :string
    field :start_date, :naive_datetime
    field :organizer_id, :id

    many_to_many :users, SecretGrinch.User,
      join_through: "match_users", on_delete: :delete_all, unique: true

    has_many :assignments, SecretGrinch.Assignment

    timestamps()
  end

  @doc false
  def changeset(%Match{} = match, attrs) do
    match
    |> cast(attrs, [:name, :start_date, :end_date, :organizer_id])
    |> validate_required([:name, :start_date, :end_date, :organizer_id])
    |> unique_constraint(:name)
  end
end
