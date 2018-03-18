defmodule Friendly.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :telephone, :string
      add :admin, :boolean, default: false, null: false

      add :task_id, references("tasks")

      timestamps()
    end

  end
end
