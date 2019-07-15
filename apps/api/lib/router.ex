defmodule Reedly.API.Router do
  @moduledoc "Reedly API router"

  use Plug.Router

  alias Plug.Conn.Status

  @init_opts [
    schema: Reedly.API.Schema,
    json_codec: Jason
  ]

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
  )

  forward("/api",
    to: Absinthe.Plug,
    init_opts: @init_opts
  )

  if Mix.env() == :dev do
    forward("/graphiql",
      to: Absinthe.Plug.GraphiQL,
      init_opts: @init_opts
    )
  end

  plug(:match)
  plug(:dispatch)

  match _ do
    status_code = Status.code(:not_found)
    reason_phrase = Status.reason_phrase(status_code)

    send_resp(conn, status_code, reason_phrase)
  end
end
