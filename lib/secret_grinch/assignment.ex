defmodule SecretGrinch.Assignment do
  use Ecto.Schema
  import Ecto.Changeset
  alias SecretGrinch.Assignment


  schema "assignments" do
    field :match_id, :id
    field :sender, :id
    field :recepient, :id

    timestamps()
  end

  @doc false
  def changeset(%Assignment{} = assignment, attrs) do
    assignment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
