defmodule CalculatorWeb.UserController do
  use CalculatorWeb, :controller

  alias Calculator.Accounts

  def create(conn, params) do
    with {:ok, user} <- Accounts.create_user(params) do
      json(conn, %{id: user.id})
    end
  end
end
