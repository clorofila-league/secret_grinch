defmodule SecretGrinch.Repo.Migrations.CreateAssignments do
  use Ecto.Migration

  def change do
    create table(:assignments) do
      add :match_id, references(:matches, on_delete: :nothing)
      add :sender_id, references(:users, on_delete: :nothing)
      add :recepient_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:assignments, [:match_id])
    create index(:assignments, [:sender_id])
    create index(:assignments, [:recepient_id])
  end
end
