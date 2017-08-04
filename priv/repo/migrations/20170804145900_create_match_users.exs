defmodule SecretGrinch.Repo.Migrations.CreateMatchUsers do
  use Ecto.Migration

  def change do
    create table(:match_users) do
      add :match_id, references(:matches, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

    end

    create index(:match_users, [:match_id])
    create index(:match_users, [:user_id])
  end
end
