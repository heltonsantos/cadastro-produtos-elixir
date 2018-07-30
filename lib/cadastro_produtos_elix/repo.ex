defmodule CadastroProdutosElix.Repo do
  use Ecto.Repo, otp_app: :cadastro_produtos_elix, adapter: Mongo.Ecto
end
