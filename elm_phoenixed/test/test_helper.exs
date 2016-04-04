ExUnit.start

Mix.Task.run "ecto.create", ~w(-r ElmPhoenixed.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r ElmPhoenixed.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(ElmPhoenixed.Repo)

