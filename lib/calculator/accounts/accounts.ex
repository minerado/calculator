defmodule Calculator.Accounts do
  @moduledoc false

  alias Calculator.Accounts.User
  alias Calculator.Repo

  def create_user(params) do
    %User{}
    |> User.registration_changeset(params)
    |> Repo.insert()
  end

  def get_user(id), do: Repo.get(User, id)

  def get_user!(id), do: Repo.get!(User, id)

  def get_user_by(params), do: Repo.get_by(User, params)

  def update_user(%User{} = user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end

  def verify_user(email, password) do
    with _ <- Bcrypt.no_user_verify(),
         %User{password_hash: hash} = user <- get_user_by(email: email),
         true <- Bcrypt.verify_pass(password, hash) do
      {:ok, user}
    else
      _ -> {:error, :wrong_user_or_password}
    end
  end
end
