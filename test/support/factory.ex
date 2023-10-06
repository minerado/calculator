defmodule Calculator.Factory do
  @moduledoc false

  use ExMachina.Ecto, repo: Calculator.Repo

  alias Calculator.Accounts.User
  alias Calculator.Operations.Operation
  alias Calculator.Records.Record

  def user_factory do
    password = sequence(:password, &"passwd-#{&1}")

    %User{
      email: sequence(:email, &"email-#{&1}@example.com"),
      password: password,
      password_hash: Bcrypt.hash_pwd_salt(password),
      status: :active,
      balance: 0
    }
  end

  def operation_factory do
    %Operation{
      cost: 1,
      type: :addition
    }
  end

  def record_factory do
    %Record{
      user_balance: 0,
      operation_params: %{param_1: 1, param_2: 1},
      operation: build(:operation),
      user: build(:user)
    }
  end
end
