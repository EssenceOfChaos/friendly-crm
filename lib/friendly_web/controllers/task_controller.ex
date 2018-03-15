defmodule FriendlyWeb.TaskController do
  use FriendlyWeb, :controller

  alias Friendly.Team
  alias Friendly.Team.Task

  plug :secure
  action_fallback FriendlyWeb.FallbackController


  def index(conn, _params) do
    tasks = Team.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end

  def new(conn, _params) do
    changeset = Team.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case Team.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Team.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Team.get_task!(id)
    changeset = Team.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Team.get_task!(id)

    case Team.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :show, task))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Team.get_task!(id)
    {:ok, _task} = Team.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end

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
