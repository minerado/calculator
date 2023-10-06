defmodule Calculator.Records do
  @moduledoc false

  alias Calculator.Accounts
  alias Calculator.Accounts.User
  alias Calculator.Records.Record
  alias Calculator.Records.RecordQuery
  alias Calculator.Repo
  alias Ecto.Multi

  def create_user_record(%User{} = user, params) do
    Multi.new()
    |> Multi.insert(:record, Record.changeset(%Record{user_id: user.id}, params))
    |> Multi.run(:user, fn _repo, %{record: %{user_balance: user_balance}} ->
      Accounts.update_user(user, %{balance: user_balance})
    end)
    |> Repo.transaction()
    |> case do
      {:ok, %{record: record}} -> {:ok, record}
      {:error, _, error, _} -> {:error, error}
    end
  end

  def count_user_records(%User{id: user_id}, opts \\ []) do
    filters = opts[:filters] || []

    filters
    |> Keyword.merge(user_id: user_id)
    |> RecordQuery.build_query()
    |> Repo.aggregate(:count, :id)
  end

  def delete_record(%Record{} = record) do
    record
    |> Record.delete_changeset()
    |> Repo.update()
  end

  def get_record(id), do: Repo.get(Record, id)

  def list_user_records(%User{id: user_id}, opts \\ []) do
    filters = opts[:filters] || []
    pagination = opts[:pagination] || []

    filters
    |> Keyword.merge(user_id: user_id)
    |> RecordQuery.build_query(pagination)
    |> Repo.all()
  end

  def update_record(%Record{} = record, params) do
    record
    |> Record.changeset(params)
    |> Repo.update()
  end
end
