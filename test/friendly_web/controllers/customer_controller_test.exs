defmodule FriendlyWeb.CustomerControllerTest do
  use FriendlyWeb.ConnCase

  alias Friendly.Accounts

  @create_attrs %{city: "some city", email: "some email", first_name: "some first_name", last_name: "some last_name", state: "some state", street_address: "some street_address", zip_code: "some zip_code"}
  @update_attrs %{city: "some updated city", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", state: "some updated state", street_address: "some updated street_address", zip_code: "some updated zip_code"}
  @invalid_attrs %{city: nil, email: nil, first_name: nil, last_name: nil, state: nil, street_address: nil, zip_code: nil}

  def fixture(:customer) do
    {:ok, customer} = Accounts.create_customer(@create_attrs)
    customer
  end

  describe "index" do
    test "lists all customers", %{conn: conn} do
      conn = get conn, customer_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Customers"
    end
  end

  describe "new customer" do
    test "renders form", %{conn: conn} do
      conn = get conn, customer_path(conn, :new)
      assert html_response(conn, 200) =~ "New Customer"
    end
  end

  describe "create customer" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, customer_path(conn, :create), customer: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == customer_path(conn, :show, id)

      conn = get conn, customer_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Customer"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, customer_path(conn, :create), customer: @invalid_attrs
      assert html_response(conn, 200) =~ "New Customer"
    end
  end

  describe "edit customer" do
    setup [:create_customer]

    test "renders form for editing chosen customer", %{conn: conn, customer: customer} do
      conn = get conn, customer_path(conn, :edit, customer)
      assert html_response(conn, 200) =~ "Edit Customer"
    end
  end

  describe "update customer" do
    setup [:create_customer]

    test "redirects when data is valid", %{conn: conn, customer: customer} do
      conn = put conn, customer_path(conn, :update, customer), customer: @update_attrs
      assert redirected_to(conn) == customer_path(conn, :show, customer)

      conn = get conn, customer_path(conn, :show, customer)
      assert html_response(conn, 200) =~ "some updated city"
    end

    test "renders errors when data is invalid", %{conn: conn, customer: customer} do
      conn = put conn, customer_path(conn, :update, customer), customer: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Customer"
    end
  end

  describe "delete customer" do
    setup [:create_customer]

    test "deletes chosen customer", %{conn: conn, customer: customer} do
      conn = delete conn, customer_path(conn, :delete, customer)
      assert redirected_to(conn) == customer_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, customer_path(conn, :show, customer)
      end
    end
  end

  defp create_customer(_) do
    customer = fixture(:customer)
    {:ok, customer: customer}
  end
end
