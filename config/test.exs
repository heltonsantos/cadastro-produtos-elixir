use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :cadastro_produtos_elix, CadastroProdutosElix.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :cadastro_produtos_elix, CadastroProdutosElix.Repo,
  database: "cadastro_produtos_test",
  hostname: "localhost"

config :exredis,
  host: "127.0.0.1",
  port: 6379,
  password: "",
  db: 0,
  reconnect: :no_reconnect,
  max_queue: :infinity

config :tirexs, :uri, "http://127.0.0.1:9200"