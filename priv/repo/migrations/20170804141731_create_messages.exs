defmodule SecretGrinch.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :subject, :string
      add :body, :text
      add :match_id, references(:matches, on_delete: :nothing)
      add :sender_id, references(:users, on_delete: :nothing)
      add :recepient_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:messages, [:match_id])
    create index(:messages, [:sender])
    create index(:messages, [:recepient])
  end
end
