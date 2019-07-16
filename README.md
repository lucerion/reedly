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

### Type checker

    mix dialyzer

### Static code analyzer

    mix credo

### Code formatter

    mix format
