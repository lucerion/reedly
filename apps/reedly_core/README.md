# Reedly Core

ORM and business logic


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
