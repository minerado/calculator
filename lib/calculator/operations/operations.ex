defmodule Calculator.Operations do
  @moduledoc false

  alias Calculator.Operations.Operation
  alias Calculator.Repo

  @string_generator_endpoint ~s(https://www.random.org/strings/?num=1&len=32&digits=on&upperalpha=on&loweralpha=on&unique=on&format=plain&rnd=new)

  def get_operation(id), do: Repo.get(Operation, id)

  def list_operations, do: Repo.all(Operation)

  def apply_operation(%{type: :addition}, x1, x2) when is_number(x1) and is_number(x2) do
    {:ok, x1 + x2}
  end

  def apply_operation(%{type: :subtraction}, x1, x2) when is_number(x1) and is_number(x2) do
    {:ok, x1 - x2}
  end

  def apply_operation(%{type: :multiplication}, x1, x2) when is_number(x1) and is_number(x2) do
    {:ok, x1 * x2}
  end

  def apply_operation(%{type: :division}, x1, x2) when is_number(x1) and is_number(x2) do
    {:ok, x1 / x2}
  end

  def apply_operation(%{type: :square_root}, x1, _x2) when is_number(x1) do
    {:ok, :math.sqrt(x1)}
  end

  def apply_operation(%{type: :random_string}, _x1, _x2), do: {:ok, random_string()}
  def apply_operation(_, _x1, _x2), do: {:error, "Invalid Operation"}

  def random_string do
    case :httpc.request(@string_generator_endpoint) do
      {:ok, {_, _, response}} -> response
      _ -> nil
    end
  end
end
