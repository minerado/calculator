defmodule CalculatorWeb.SessionController do
  use CalculatorWeb, :controller

  alias Calculator.Accounts
  alias Calculator.Guardian

  def create(conn, %{"email" => email, "password" => password}) do
    with {:ok, user} <- Accounts.verify_user(email, password),
         {:ok, token, _} <- Guardian.encode_and_sign(user) do
      json(conn, %{jwt: token})
    else
      _ -> conn |> put_status(401) |> json(%{error: "Invalid credentials"})
    end
  end
end
