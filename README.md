# Reedly

Stand-alone web content (RSS/Atom, links) aggregator


## Setup

    mix deps.get


## Dependencies

  * `erlang-dev` (httpoison, timex)
  * `erlang-dialyzer` (dialyzer)
  * `erlang-parsetools` (timex)
  * `erlang-tools` (mock)
  * `erlang-xmerl` (feeder_ex)


## Development

Run tests, type checker and static code analyzer

    mix check

### Tests

  * [setup tests](apps/database#tests) for the `database` app
  * run

        mix test

### Type checker

    mix dialyzer

### Static code analyzer

    mix credo

### Code formatter

    mix format
