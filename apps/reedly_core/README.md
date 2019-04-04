# Reedly Core

Data access layer


## Setup

  * install dependencies

        mix deps.get

  * install [PostgreSQL](https://postgresql.org) database

  * export `DATABASE_URL` env variable

        export DATABASE_URL="http://user:password@host:port/reedly"

  * create a database

        mix ecto.create

  * run migrations

        mix ecto.migrate


## Development

### Tests

  * export `TEST_DATABASE_URL` env variable

        export TEST_DATABASE_URL="http://user:password@host:port/reedly_test"

  * create a database

        MIX_ENV=test mix ecto.create

  * run migrations

        MIX_ENV=test mix ecto.migrate

  * run tests

        mix test
