defmodule Calculator.Repo.Migrations.CreateRecordsTable do
  use Ecto.Migration

  def change do
    create table(:records, primary_key: false) do
      add(:id, :uuid, primary_key: true, null: false, default: fragment("gen_random_uuid()"))
      add(:user_id, references(:users, type: :binary_id), null: false)
      add(:operation_id, references(:operations, type: :binary_id), null: false)

      add(:user_balance, :integer, null: false)

      add(:operation_params, :jsonb,
        null: false,
        default: "{\"param_1\": null, \"param_2\": null}"
      )

      add(:operation_response, :jsonb, null: false, default: "{\"value\": null}")

      add(:deleted_at, :naive_datetime)

      timestamps()
    end
  end
end
