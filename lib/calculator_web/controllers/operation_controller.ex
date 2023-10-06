defmodule CalculatorWeb.OperationController do
  use CalculatorWeb, :controller

  alias Calculator.Accounts.User
  alias Calculator.Operations

  def index(conn, _params) do
    with %User{} <- Guardian.Plug.current_resource(conn),
         operations <- Operations.list_operations() do
      json(conn, %{operations: operations})
    end
  end
end
