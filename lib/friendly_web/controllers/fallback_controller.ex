defmodule FriendlyWeb.FallbackController do
  use FriendlyWeb, :controller

    def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
      conn
      |> put_status(:unprocessable_entity)
      |> render(FriendlyWeb.ChangesetView, "error.json", changeset: changeset)
    end

    def call(conn, {:error, :not_found}) do
      conn
      |> put_status(:not_found)
      |> render(FriendlyWeb.ErrorView, :"404")
    end

end