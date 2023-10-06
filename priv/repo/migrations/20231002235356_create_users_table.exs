defmodule Calculator.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def up do
    execute("CREATE EXTENSION IF NOT EXISTS pgcrypto")

    UserStatusEnum.create_type()

    create table(:users, primary_key: false) do
      add(:id, :uuid, primary_key: true, null: false, default: fragment("gen_random_uuid()"))
      add(:email, :string, null: false)
      add(:password_hash, :string, null: false)
      add(:status, UserStatusEnum.type(), null: false)
      add(:balance, :integer, null: false, default: 0)

      add(:deleted_at, :naive_datetime)

      timestamps()
    end

    create(index(:users, [:email], unique: true))
  end

  def down do
    drop(table(:users))

    UserStatusEnum.drop_type()
  end
end
