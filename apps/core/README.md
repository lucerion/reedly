# Reedly Core

ORM and business logic


## Setup

  * install PostgreSQL database

  * copy `.env.example` to `.env`. Edit `.env`

  * import env variables

        source .env

  * install dependencies

        mix deps.get

  * create a database

        mix ecto.create

  * run migrations

        mix ecto.migrate
