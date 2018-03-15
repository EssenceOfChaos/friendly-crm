defmodule Friendly.Repo.Migrations.AddFieldsToTasks do
  use Ecto.Migration

  def change do
    alter table(:tasks) do
      add :complete, :boolean
    end

  end
end
