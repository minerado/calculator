defmodule CalculatorWeb.Helpers do
  @moduledoc false

  def action_params_opts(params) do
    [filters: build_filters(params), pagination: build_pagination(params)]
  end

  defp build_pagination(%{"pagination" => %{"page" => page, "page_size" => page_size}}) do
    [
      page: String.to_integer(page),
      per_page: String.to_integer(page_size)
    ]
  end

  defp build_pagination(%{"pagination" => %{"page" => page}}) do
    [page: String.to_integer(page)]
  end

  defp build_pagination(_), do: []

  defp build_filters(%{"filters" => filters}) do
    Enum.map(filters, fn {k, v} -> {String.to_existing_atom(k), v} end)
  end

  defp build_filters(_), do: []

  def get_current_user(conn) do
    case Guardian.Plug.current_resource(conn) do
      nil -> {:error, :unauthorized}
      user -> {:ok, user}
    end
  end

  def test do
    1
  end
end
