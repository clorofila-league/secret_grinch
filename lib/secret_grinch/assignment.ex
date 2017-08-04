defmodule SecretGrinch.Assignment do
  @moduledoc """
  Represents the relationship between a sender and a recipient for a match
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias SecretGrinch.Assignment


  schema "assignments" do
    field :match_id, :id
    field :sender_id, :id
    field :recepient_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Assignment{} = assignment, attrs) do
    assignment
    |> cast(attrs, [])
    |> validate_required([])
  end
end
