defmodule SecretGrinch.Repo.Migrations.CreateMatches do
  use Ecto.Migration

  def change do
    create table(:matches) do
      add :name, :string
      add :start_date, :naive_datetime
      add :end_date, :naive_datetime
      add :organizer_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:matches, [:name])
    create index(:matches, [:organizer_id])
  end
end
