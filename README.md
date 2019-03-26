# Reedly

[![Build Status](https://travis-ci.org/lucerion/reedly.svg?branch=master)](https://travis-ci.org/lucerion/reedly)

Stand-alone RSS aggregator


## Setup

    mix deps.get


## Development

### Tests

    export TEST_DATABASE_URL="http://user:password@host:port/reedly_test"
    MIX_ENV=test mix ecto.create
    MIX_ENV=test mix ecto.migrate
    mix test

### Type checker

    mix dialyzer

### Static code analyzer

    mix credo

### Code formatter

    mix format


## Dependencies

  * erlang-dev
  * erlang-dialyzer
  * erlang-tools
  * erlang-xmerl
