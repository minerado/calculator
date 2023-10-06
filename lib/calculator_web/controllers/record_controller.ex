defmodule CalculatorWeb.RecordController do
  use CalculatorWeb, :controller

  alias Calculator.Accounts.User
  alias Calculator.Records
  alias Calculator.Records.Record
  alias Calculator.Repo
  alias CalculatorWeb.Helpers

  def create(conn, params) do
    with %User{} = user <- Guardian.Plug.current_resource(conn),
         {:ok, record} <- Records.create_user_record(user, params) do
      json(conn, %{record: Repo.preload(record, [:operation, :user])})
    end
  end

  def delete(conn, %{"id" => id}) do
    with %User{} <- Guardian.Plug.current_resource(conn),
         %Record{} = record <- Records.get_record(id),
         {:ok, record} <- Records.delete_record(record) do
      json(conn, %{record: Repo.preload(record, [:operation, :user])})
    end
  end

  def update(conn, %{"id" => id} = params) do
    with %User{} <- Guardian.Plug.current_resource(conn),
         %Record{} = record <- Records.get_record(id),
         {:ok, record} <- Records.update_record(record, params) do
      json(conn, %{record: Repo.preload(record, [:operation, :user])})
    end
  end

  def index(conn, params) do
    with %User{} = user <- Guardian.Plug.current_resource(conn),
         opts <- Helpers.action_params_opts(params),
         records <- Records.list_user_records(user, opts),
         records_count <- Records.count_user_records(user, opts) do
      json(conn, %{records: Repo.preload(records, [:operation, :user]), total: records_count})
    end
  end
end
