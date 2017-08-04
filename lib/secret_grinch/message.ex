defmodule SecretGrinch.Message do
  use Ecto.Schema
  import Ecto.Changeset
  alias SecretGrinch.Message


  schema "messages" do
    field :body, :string
    field :subject, :string
    field :match_id, :id
    field :sender, :id
    field :recepient, :id

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:subject, :body])
    |> validate_required([:subject, :body])
  end
end
