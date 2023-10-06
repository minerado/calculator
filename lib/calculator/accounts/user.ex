defmodule Calculator.Accounts.User do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  @type t :: %User{}

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @derive {Jason.Encoder, only: [:balance, :email, :status]}

  schema "users" do
    field(:email, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:status, UserStatusEnum, default: :active)
    field(:balance, :integer)

    timestamps()
  end

  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:balance, :email, :status])
    |> validate_required([:email, :status])
    |> unique_constraint([:email])
  end

  def registration_changeset(%User{} = user, params \\ %{}) do
    user
    |> changeset(params)
    |> cast(params, [:password], [])
    |> validate_required([:password])
    |> hash_password
    |> put_change(:password, nil)
  end

  defp hash_password(%Ecto.Changeset{valid?: true, changes: %{password: pass}} = cs) do
    put_change(cs, :password_hash, Bcrypt.hash_pwd_salt(pass))
  end

  defp hash_password(changeset), do: changeset
end
