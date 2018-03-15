defmodule Friendly.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :description, :string
      add :due, :naive_datetime

      timestamps()
    end

  end
end
