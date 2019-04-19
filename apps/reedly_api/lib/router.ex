defmodule Reedly.API.Router do
  @moduledoc "Reedly API router"

  use Plug.Router

  plug(:match)
  plug(:dispatch)

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
  )

  forward("/api",
    to: Absinthe.Plug,
    init_opts: [schema: Reedly.API.Schema, json_codec: Jason]
  )

  forward("/graphiql",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [schema: Reedly.API.Schema, json_codec: Jason]
  )

  match _ do
    send_resp(conn, 404, "Bad Request")
  end
end
