Application.ensure_all_started(:bypass)

ExUnit.start()
Faker.start()

Ecto.Adapters.SQL.Sandbox.mode(Reedly.Core.Repo, :manual)
