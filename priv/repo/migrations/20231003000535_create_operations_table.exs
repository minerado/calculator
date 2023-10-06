defmodule Calculator.Repo.Migrations.CreateOperationsTable do
  use Ecto.Migration

  def change do
    OperationTypeEnum.create_type()

    create table(:operations, primary_key: false) do
      add(:id, :uuid, primary_key: true, null: false, default: fragment("gen_random_uuid()"))
      add(:type, OperationTypeEnum.type(), null: false)
      add(:cost, :integer, null: false)

      add(:deleted_at, :naive_datetime)

      timestamps()
    end
  end
end
