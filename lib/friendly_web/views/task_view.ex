defmodule FriendlyWeb.TaskView do
  use FriendlyWeb, :view


  def get_date() do
    d = DateTime.utc_now()
    f = DateTime.to_date(d)
  end

end
