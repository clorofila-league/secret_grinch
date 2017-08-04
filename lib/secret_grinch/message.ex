defmodule SecretGrinch.Message do
  @moduledoc """
  Represents a message of the system
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias SecretGrinch.Message


  schema "messages" do
    field :body, :string
    field :subject, :string
    field :match_id, :id
    field :sender_id, :id
    field :recepient_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Message{} = message, attrs) do
    message
    |> cast(attrs, [:subject, :body])
    |> validate_required([:subject, :body])
  end

  def put_match_id(changeset, match_id) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :match_id, match_id)
      _ ->
        changeset
    end
  end

  def put_sender_id(changeset, sender_id) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :sender_id, sender_id)
      _ ->
        changeset
    end
  end

  def put_recepient_id(changeset, recepient_id) do
    case changeset do
      %Ecto.Changeset{valid?: true} ->
        put_change(changeset, :recepient_id, recepient_id)
      _ ->
        changeset
    end
  end

end
