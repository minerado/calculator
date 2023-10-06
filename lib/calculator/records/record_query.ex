defmodule Calculator.Records.RecordQuery do
  use QueryElf,
    schema: Calculator.Records.Record,
    searchable_fields: [:inserted_at, :user_id],
    sortable_fields: [:inserted_at],
    plugins: [
      {QueryElf.Plugins.OffsetPagination, default_per_page: 5}
    ]

  alias Calculator.Records.Record

  def base_query do
    from(r in Record, as: :r)
    |> where([r: r], is_nil(r.deleted_at))
  end

  def filter(:operation, value, query) do
    query
    |> reusable_join(:inner, [r: r], o in assoc(r, :operation), as: :o)
    |> then(&{&1, dynamic([o: o], o.type == ^value)})
  end
end
