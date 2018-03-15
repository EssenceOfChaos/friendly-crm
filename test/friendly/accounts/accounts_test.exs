defmodule Friendly.AccountsTest do
  use Friendly.DataCase

  alias Friendly.Accounts

  describe "customers" do
    alias Friendly.Accounts.Customer

    @valid_attrs %{city: "some city", email: "some email", first_name: "some first_name", last_name: "some last_name", state: "some state", street_address: "some street_address", zip_code: "some zip_code"}
    @update_attrs %{city: "some updated city", email: "some updated email", first_name: "some updated first_name", last_name: "some updated last_name", state: "some updated state", street_address: "some updated street_address", zip_code: "some updated zip_code"}
    @invalid_attrs %{city: nil, email: nil, first_name: nil, last_name: nil, state: nil, street_address: nil, zip_code: nil}

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Accounts.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Accounts.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Accounts.create_customer(@valid_attrs)
      assert customer.city == "some city"
      assert customer.email == "some email"
      assert customer.first_name == "some first_name"
      assert customer.last_name == "some last_name"
      assert customer.state == "some state"
      assert customer.street_address == "some street_address"
      assert customer.zip_code == "some zip_code"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, customer} = Accounts.update_customer(customer, @update_attrs)
      assert %Customer{} = customer
      assert customer.city == "some updated city"
      assert customer.email == "some updated email"
      assert customer.first_name == "some updated first_name"
      assert customer.last_name == "some updated last_name"
      assert customer.state == "some updated state"
      assert customer.street_address == "some updated street_address"
      assert customer.zip_code == "some updated zip_code"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_customer(customer, @invalid_attrs)
      assert customer == Accounts.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Accounts.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Accounts.change_customer(customer)
    end
  end
end
