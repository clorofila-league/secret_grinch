defmodule SecretGrinch.MessageService do
  @moduledoc false
  alias Ecto.Multi

  def insert(message_changeset) do
    Multi.new
    |> Multi.insert(:message, message_changeset)
    |> Multi.run(:send_message, &send_message/1)
  end

  defp send_message(%{message: message}) do
    result1 =
      message
      |> SecretGrinch.Email.message_email
      |> SecretGrinch.Mailer.deliver_later

    result2 =
      message
      |> SecretGrinch.Email.message_copy_email
      |> SecretGrinch.Mailer.deliver_later

    {:ok, {result1, result2}}
  end
end
