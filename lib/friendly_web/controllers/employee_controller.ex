defmodule FriendlyWeb.EmployeeController do
  use FriendlyWeb, :controller

  alias Friendly.Team
  alias Friendly.Team.Employee


  plug :secure
  action_fallback FriendlyWeb.FallbackController


  def index(conn, _params) do
    employees = Team.list_employees()
    render(conn, "index.html", employees: employees)
  end

  def new(conn, _params) do
    changeset = Team.change_employee(%Employee{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"employee" => employee_params}) do
    case Team.create_employee(employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee created successfully.")
        |> redirect(to: employee_path(conn, :show, employee))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = Team.get_employee!(id)
    render(conn, "show.html", employee: employee)
  end

  def edit(conn, %{"id" => id}) do
    employee = Team.get_employee!(id)
    changeset = Team.change_employee(employee)
    render(conn, "edit.html", employee: employee, changeset: changeset)
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Team.get_employee!(id)

    case Team.update_employee(employee, employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee updated successfully.")
        |> redirect(to: employee_path(conn, :show, employee))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", employee: employee, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Team.get_employee!(id)
    {:ok, _employee} = Team.delete_employee(employee)

    conn
    |> put_flash(:info, "Employee deleted successfully.")
    |> redirect(to: employee_path(conn, :index))
  end

  #private function
  defp secure(conn, _params) do
    user = get_session(conn, :current_user)
    case user do
      nil ->
          conn |> redirect(to: "/auth/auth0") |> halt
      _ ->
        conn
        |> assign(:current_user, user)
    end
  end
  
end
