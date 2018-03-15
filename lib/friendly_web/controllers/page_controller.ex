defmodule FriendlyWeb.PageController do
  use FriendlyWeb, :controller
  alias Friendly.Team

  def index(conn, _params) do
    upcoming = Team.list_future_tasks()
    overdue = Team.list_overdue_tasks()
    render conn, "index.html", 
    upcoming_tasks: upcoming, 
    overdue_tasks: overdue,
    current_user: get_session(conn, :current_user)
  end
end
