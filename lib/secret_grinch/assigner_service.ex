defmodule SecretGrinch.AssignerService do
  alias SecretGrinch.Matches.Match
  alias SecretGrinch.Repo
  alias SecretGrinch.Assignment

  def run(%Match{} = match) do
    match = Repo.preload(match, :users)

    assign!(match, match.users, match.users)

  end

  defp assign!(_match, [], []) do
    :ok
  end
  defp assign!(match, [user], [user]) do
    %Assignment{match_id: match.id, sender_id: user.id, recepient_id: user.id}
    |> Repo.insert!
  end
  defp assign!(match, [sender | senders], recipients) do
    [recipient] = Enum.take_random(recipients -- [sender], 1)

    %Assignment{match_id: match.id, sender_id: sender.id, recepient_id: recipient.id}
    |> Repo.insert!

    assign!(match, senders, recipients -- [recipient])
  end

end
