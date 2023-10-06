defmodule Calculator.Operations.OperationParams do
  @moduledoc false

  use Ecto.Schema

  import Ecto.Changeset

  alias __MODULE__

  @derive {Jason.Encoder, only: [:param_1, :param_2]}

  embedded_schema do
    field :param_1, :integer
    field :param_2, :integer
  end

  def changeset(%OperationParams{} = operation_params, attrs \\ %{}) do
    operation_params
    |> cast(attrs, [:param_1, :param_2])
  end
end
