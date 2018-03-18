defmodule Friendly.TeamTest do
  use Friendly.DataCase

  alias Friendly.Team

  describe "tasks" do
    alias Friendly.Team.Task

    @valid_attrs %{description: "some description", due: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{description: "some updated description", due: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{description: nil, due: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Team.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Team.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Team.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Team.create_task(@valid_attrs)
      assert task.description == "some description"
      assert task.due == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Team.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Team.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.description == "some updated description"
      assert task.due == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Team.update_task(task, @invalid_attrs)
      assert task == Team.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Team.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Team.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Team.change_task(task)
    end
  end

  describe "employees" do
    alias Friendly.Team.Employee

    @valid_attrs %{admin: true, email: "some email", first_name: "some first_name", last_name: "some last_name", telephone: "some telephone"}
    @update_attrs %{admin: false, email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", telephone: "some updated telephone"}
    @invalid_attrs %{admin: nil, email: nil, first_name: nil, last_name: nil, telephone: nil}

    def employee_fixture(attrs \\ %{}) do
      {:ok, employee} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Team.create_employee()

      employee
    end

    test "list_employees/0 returns all employees" do
      employee = employee_fixture()
      assert Team.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      employee = employee_fixture()
      assert Team.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      assert {:ok, %Employee{} = employee} = Team.create_employee(@valid_attrs)
      assert employee.admin == true
      assert employee.email == "some email"
      assert employee.first_name == "some first_name"
      assert employee.last_name == "some last_name"
      assert employee.telephone == "some telephone"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Team.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      employee = employee_fixture()
      assert {:ok, employee} = Team.update_employee(employee, @update_attrs)
      assert %Employee{} = employee
      assert employee.admin == false
      assert employee.email == "some updated email"
      assert employee.first_name == "some updated first_name"
      assert employee.last_name == "some updated last_name"
      assert employee.telephone == "some updated telephone"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      employee = employee_fixture()
      assert {:error, %Ecto.Changeset{}} = Team.update_employee(employee, @invalid_attrs)
      assert employee == Team.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      employee = employee_fixture()
      assert {:ok, %Employee{}} = Team.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Team.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      employee = employee_fixture()
      assert %Ecto.Changeset{} = Team.change_employee(employee)
    end
  end
end
