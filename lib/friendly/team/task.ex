defmodule Friendly.Team.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @moduledoc """
    Module for defining Tasks.
  """


  schema "tasks" do
    field :description, :string
    field :due, :naive_datetime
    field :complete, :boolean, default: false
    belongs_to :employee, Friendly.Team.Employee

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:description, :due, :complete])
    |> validate_required([:description, :due])
    |> Ecto.Changeset.assoc_constraint(:employee)
  end
end
