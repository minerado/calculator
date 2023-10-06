defmodule Calculator.Operations.OperationResponse do
  @moduledoc false

  use Ecto.Schema

  @derive {Jason.Encoder, only: [:value]}

  embedded_schema do
    field :value, :string
  end
end
