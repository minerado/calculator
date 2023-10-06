defmodule CalculatorWeb.UserController do
  use CalculatorWeb, :controller

  alias Calculator.Accounts
  alias Calculator.Accounts.User

  def create(conn, params) do
    with {:ok, user} <- Accounts.create_user(params) do
      json(conn, %{id: user.id})
    end
  end

  def show(conn, %{"id" => "current"}) do
    with %User{} = user <- Guardian.Plug.current_resource(conn) do
      json(conn, %{user: user})
    end
  end
end
