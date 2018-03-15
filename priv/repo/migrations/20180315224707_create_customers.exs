defmodule Friendly.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :first_name, :string
      add :last_name, :string
      add :email, :string
      add :street_address, :string
      add :city, :string
      add :state, :string
      add :zip_code, :integer

      timestamps()
    end

    create unique_index(:customers, [:email])
  end
end
