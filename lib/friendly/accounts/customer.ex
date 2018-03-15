defmodule Friendly.Accounts.Customer do
  use Ecto.Schema
  import Ecto.Changeset


  schema "customers" do
    field :city, :string
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :state, :string
    field :street_address, :string
    field :zip_code, :integer

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:first_name, :last_name, :email, :street_address, :city, :state, :zip_code])
    |> validate_required([:first_name, :last_name, :email, :street_address, :city, :state, :zip_code])
    |> unique_constraint(:email)
  end
end
