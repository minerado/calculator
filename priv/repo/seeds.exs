# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Calculator.Repo.insert!(%Calculator.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Calculator.Operations.Operation
alias Calculator.Repo

Repo.insert!(Operation.changeset(%Operation{}, %{cost: 1, type: :addition}))
Repo.insert!(Operation.changeset(%Operation{}, %{cost: 2, type: :subtraction}))
Repo.insert!(Operation.changeset(%Operation{}, %{cost: 3, type: :multiplication}))
Repo.insert!(Operation.changeset(%Operation{}, %{cost: 4, type: :division}))
Repo.insert!(Operation.changeset(%Operation{}, %{cost: 5, type: :square_root}))
Repo.insert!(Operation.changeset(%Operation{}, %{cost: 6, type: :random_string}))
