# Reedly Database

Database access layer


## Setup

  * install dependencies

        mix deps.get

  * install [PostgreSQL](https://postgresql.org) database

  * export `DATABASE_URL` env variable

        export DATABASE_URL="http://user:password@host:port/reedly"

  * create a database and run migrations

        mix setup


## Development

Run tests, type checker and static code analyzer

    mix check

### Tests

  * export `TEST_DATABASE_URL` env variable

        export TEST_DATABASE_URL="http://user:password@host:port/reedly_test"

  * create a database and run migrations

        MIX_ENV=test mix setup

  * run tests

        mix test

### Type checker

    mix dialyzer

### Static code analyzer

    mix credo

### Code formatter

    mix format
