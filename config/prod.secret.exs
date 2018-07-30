use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :cadastro_produtos_elix, CadastroProdutosElix.Endpoint,
  secret_key_base: "riq/EPIRcgISpY44rk/Mvc7FFxWxieIC5gBAoFDtpVAaSzyU7R1/ZintwThrg8eJ"

# Configure your database
config :cadastro_produtos_elix, CadastroProdutosElix.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "cadastro_produtos_elix_prod",
  pool_size: 15
