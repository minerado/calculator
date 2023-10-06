defmodule Calculator.Operations.Operation do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  @type t :: %Operation{}

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  @derive {Jason.Encoder, only: [:id, :cost, :type]}

  schema "operations" do
    field(:cost, :integer)
    field(:type, OperationTypeEnum)

    timestamps()
  end

  def changeset(%Operation{} = operation, attrs \\ %{}) do
    operation
    |> cast(attrs, [:cost, :type])
    |> validate_required([:cost, :type])
  end
end
