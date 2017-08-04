defmodule SecretGrinch.MessageService do
  @moduledoc false
  alias Ecto.Multi

  def insert(message_changeset) do
    Multi.new
    |> Multi.insert(:message, message_changeset)
    |> Multi.run(:send_message, &send_message/1)
  end

  defp send_message(%{message: message}) do
    result =
      message
      |> SecretGrinch.Email.message_email
      |> SecretGrinch.Mailer.deliver_later

    {:ok, result}
  end
end
