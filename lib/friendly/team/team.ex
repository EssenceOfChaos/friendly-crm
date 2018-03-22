defmodule Friendly.Team do
  @moduledoc """
  The Team context.
  """

  import Ecto.Query, warn: false
  alias Friendly.Repo

  alias Friendly.Team.Task


  def list_tasks do
   Repo.all from t in Task,
   preload: [:employee]
  end

  def list_future_tasks do
    query = from t in Friendly.Team.Task,
      where: t.due >= ^DateTime.utc_now
      Repo.all(query)
  end

  def list_overdue_tasks do
    query = from t in Friendly.Team.Task,
    where: t.due < ^DateTime.utc_now
    Repo.all(query)
  end


  def get_task!(id) do 
    Repo.get!(Task, id) |> Repo.preload(:employee)
  end


  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end


  def update_task(%Task{} = task, attrs) do
    task
    |> Task.changeset(attrs)
    |> Repo.update()
  end


  def delete_task(%Task{} = task) do
    Repo.delete(task)
  end

  def change_task(%Task{} = task) do
    Task.changeset(task, %{})
  end

############ ~~~~~~ ###### ~~~~~~ ###### ~~~~~# 
#  ##        EMPLOYEE SCHEMA BELOW        ##  #
#                                             #
#                                             #
#                                             #
#                                             #
###############################################


alias Friendly.Team.Employee


  def list_employees do
    Repo.all from e in Employee,
    preload: [:tasks]
  end


  def get_employee!(id), do: Repo.get!(Employee, id) |> Repo.preload(:tasks)


  def create_employee(attrs \\ %{}) do
    %Employee{}
    |> Employee.changeset(attrs)
    |> Repo.insert()
  end

  def update_employee(%Employee{} = employee, attrs) do
    employee
    |> Employee.changeset(attrs)
    |> Repo.update()
  end


  def delete_employee(%Employee{} = employee) do
    Repo.delete(employee)
  end

  def change_employee(%Employee{} = employee) do
    Employee.changeset(employee, %{})
  end
end
