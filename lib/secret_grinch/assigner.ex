defmodule SecretGrinch.Assigner do
  @moduledoc false
  use GenServer
  alias SecretGrinch.Repo
  alias SecretGrinch.Matches.Match
  alias SecretGrinch.AssignerService
  import Ecto.Query

  @frequency 20_000

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, [name: __MODULE__])
  end

  def init(:ok) do
    {:ok, %{}, @frequency}
  end

  def handle_info(:timeout, state) do
    now =
      Ecto.DateTime.utc
      |> Ecto.DateTime.to_erl
      |> NaiveDateTime.from_erl!

    matches = Repo.all(
      from match in Match,
      where: match.start_date <= ^now
    )

    matches
    |> Enum.map(&Repo.preload(&1, :assignments))
    |> Enum.filter(&(length(&1.assignments) == 0))
    |> Enum.map(&AssignerService.run(&1))

    {:noreply, state, @frequency}
  end

  def handle_info(_msg, state) do
    {:noreply, state, @frequency}
  end
end
