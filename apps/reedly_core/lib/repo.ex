defmodule Reedly.Core.Repo do
  use Ecto.Repo,
    adapter: Ecto.Adapters.Postgres,
    otp_app: :reedly_core
end
