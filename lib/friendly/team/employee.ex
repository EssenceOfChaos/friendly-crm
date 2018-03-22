defmodule Friendly.Team.Employee do
  use Ecto.Schema
  import Ecto.Changeset

    @moduledoc """
    Module for defining Employees.
    """
  schema "employees" do
    field :admin, :boolean, default: false
    field :email, :string
    field :first_name, :string
    field :last_name, :string
    field :telephone, :string

    has_many :tasks, Friendly.Team.Task

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :email, :telephone, :admin])
    |> validate_required([:first_name, :last_name, :email, :telephone, :admin])
    |> validate_format(:email, ~r/(\w+)@([\w.]+)/)
  end
end
