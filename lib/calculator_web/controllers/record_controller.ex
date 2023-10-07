defmodule CalculatorWeb.RecordController do
  use CalculatorWeb, :controller

  alias Calculator.Records
  alias Calculator.Records.Record
  alias Calculator.Repo
  alias CalculatorWeb.Helpers

  action_fallback CalculatorWeb.FallbackController

  def create(conn, params) do
    with {:ok, user} <- Helpers.get_current_user(conn),
         {:ok, record} <- Records.create_user_record(user, params) do
      json(conn, %{record: Repo.preload(record, [:operation, :user])})
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, _} <- Helpers.get_current_user(conn),
         %Record{} = record <- Records.get_record(id),
         {:ok, record} <- Records.delete_record(record) do
      json(conn, %{record: Repo.preload(record, [:operation, :user])})
    end
  end

  def update(conn, %{"id" => id} = params) do
    with {:ok, _} <- Helpers.get_current_user(conn),
         %Record{} = record <- Records.get_record(id),
         {:ok, record} <- Records.update_record(record, params) do
      json(conn, %{record: Repo.preload(record, [:operation, :user])})
    end
  end

  def index(conn, params) do
    with {:ok, user} <- Helpers.get_current_user(conn),
         opts <- Helpers.action_params_opts(params),
         records <- Records.list_user_records(user, opts),
         records_count <- Records.count_user_records(user, opts) do
      json(conn, %{records: Repo.preload(records, [:operation, :user]), total: records_count})
    end
  end
end
