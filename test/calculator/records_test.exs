defmodule Calculator.RecordsTest do
  use Calculator.DataCase

  import Calculator.Factory

  alias Calculator.Accounts
  alias Calculator.Records

  describe "when creating a record" do
    test "it returns the record when passing valid parameters" do
      operation = insert(:operation, cost: 1)
      user = insert(:user, balance: 100)

      operation_params = %{param_1: 11, param_2: 31}

      assert {:ok, _} =
               Records.create_user_record(user, %{
                 operation_id: operation.id,
                 operation_params: operation_params
               })
    end

    test "it returns the record with the correct answer for given operation" do
      operation = insert(:operation, cost: 1)
      user = insert(:user, balance: 100)

      operation_params = %{param_1: 11, param_2: 31}

      assert {:ok, %{operation_response: %{value: 42}}} =
               Records.create_user_record(user, %{
                 operation_id: operation.id,
                 operation_params: operation_params
               })
    end

    test "it returns the record with the correct user balance discounted by the operation cost" do
      operation = insert(:operation, cost: 99)
      user = insert(:user, balance: 100)

      operation_params = %{param_1: 11, param_2: 31}

      assert {:ok, %{user_balance: 1}} =
               Records.create_user_record(user, %{
                 operation_id: operation.id,
                 operation_params: operation_params
               })

      assert %{balance: 100} = user
      assert %{balance: 1} = Accounts.get_user(user.id)
    end

    test "it returns an error when the user has a balance that's lower than the operation cost" do
      operation = insert(:operation, cost: 101)
      user = insert(:user, balance: 100)

      operation_params = %{param_1: 11, param_2: 31}

      assert {:error, _} =
               Records.create_user_record(user, %{
                 operation_id: operation.id,
                 operation_params: operation_params
               })

      assert %{balance: 100} = user
      assert %{balance: 100} = Accounts.get_user(user.id)
    end
  end

  describe "when listing records" do
    test "it returns a valid list of records" do
      user = insert(:user)
      operation = insert(:operation)

      insert_list(3, :record, operation: operation, user: user)

      assert [_, _, _] = Records.list_user_records(user)
    end
  end
end
