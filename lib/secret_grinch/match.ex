defmodule SecretGrinch.Match do
  use Ecto.Schema
  import Ecto.Changeset
  alias SecretGrinch.Match


  schema "matches" do
    field :end_date, :naive_datetime
    field :name, :string
    field :start_date, :naive_datetime
    field :organizer_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Match{} = match, attrs) do
    match
    |> cast(attrs, [:name, :start_date, :end_date])
    |> validate_required([:name, :start_date, :end_date])
    |> unique_constraint(:name)
  end
end
