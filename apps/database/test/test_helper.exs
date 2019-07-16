Application.ensure_all_started(:bypass)

ExUnit.start()
Faker.start()

Ecto.Adapters.SQL.Sandbox.mode(Reedly.Database.Repo, :manual)
