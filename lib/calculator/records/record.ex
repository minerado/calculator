defmodule Calculator.Records.Record do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__
  alias Calculator.Accounts
  alias Calculator.Accounts.User
  alias Calculator.Operations
  alias Calculator.Operations.Operation
  alias Calculator.Operations.OperationParams
  alias Calculator.Operations.OperationResponse

  @type t :: %Record{}

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @foreign_key_type :binary_id

  @derive {Jason.Encoder,
           only: [
             :id,
             :inserted_at,
             :operation,
             :operation_params,
             :operation_response,
             :user,
             :user_balance
           ]}

  schema "records" do
    field(:user_balance, :integer)
    field(:deleted_at, :naive_datetime)

    embeds_one :operation_params, OperationParams
    embeds_one :operation_response, OperationResponse

    belongs_to(:operation, Operation)
    belongs_to(:user, User)

    timestamps()
  end

  def changeset(%Record{} = record, attrs \\ %{}) do
    record
    |> cast(attrs, [:user_id, :operation_id])
    |> validate_required([:operation_id])
    |> handle_operation()
    |> cast_embed(:operation_params)
    |> cast_operation_response()
  end

  def delete_changeset(%Record{} = record, _attrs \\ %{}) do
    datetime = NaiveDateTime.truncate(NaiveDateTime.utc_now(), :second)

    change(record, %{deleted_at: datetime})
  end

  defp cast_operation_response(
         %{
           changes: %{
             operation_id: operation_id,
             operation_params: %{changes: changes}
           }
         } = changeset
       ) do
    with %Operation{} = operation <- Operations.get_operation(operation_id),
         {:ok, result} <-
           Operations.apply_operation(operation, changes[:param_1], changes[:param_2]),
         result <- to_string(result) do
      changeset
      |> put_change(:operation_response, %{value: result})
      |> cast_embed(:operation_response)
    else
      {:error, message} -> add_error(changeset, :operation_id, message)
      _ -> add_error(changeset, :operation_id, "Operation not found")
    end
  end

  defp cast_operation_response(changeset), do: changeset

  defp handle_operation(%{changes: %{operation_id: operation_id}, data: record} = changeset) do
    with %Operation{cost: cost} <- Operations.get_operation(operation_id),
         %User{balance: balance} when balance >= cost <- Accounts.get_user(record.user_id) do
      put_change(changeset, :user_balance, balance - cost)
    else
      nil -> add_error(changeset, :operation_id, "Not found")
      _ -> add_error(changeset, :user_balance, "Insufficient funds")
    end
  end

  defp handle_operation(changeset), do: changeset
end
