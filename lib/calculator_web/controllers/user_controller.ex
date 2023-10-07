defmodule CalculatorWeb.UserController do
  use CalculatorWeb, :controller

  alias Calculator.Accounts
  alias CalculatorWeb.Helpers

  action_fallback(CalculatorWeb.FallbackController)

  def create(conn, params) do
    with {:ok, user} <- Accounts.create_user(params) do
      json(conn, %{id: user.id})
    end
  end

  def show(conn, %{"id" => "current"}) do
    with {:ok, user} <- Helpers.get_current_user(conn) do
      json(conn, %{user: user})
    end
  end
end
