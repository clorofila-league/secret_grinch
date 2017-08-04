defmodule SecretGrinch.Email do
  @moduledoc false
  use Bamboo.Phoenix, view: EmailView.EmailView
  alias SecretGrinch.Repo
  alias SecretGrinch.Assignment
  alias SecretGrinch.User

  def message_email(message) do
    assignment = Repo.get_by!(Assignment, match_id: message.match_id, sender_id: message.sender_id)
    recipient = Repo.get!(User, assignment.recepient_id)
    new_email
    |> to(recipient.email)
    |> from("@secretgrinch.com")
    |> subject("SecretGrinch: #{message.subject}")
    |> text_body(message.body)
  end
end
