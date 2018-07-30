defmodule CadastroProdutosElix.Repo.Migrations.CreateProduto do
  use Ecto.Migration

  def change do
    create table(:produtos) do
      add :sku, :string
      add :nome, :string
      add :descricao, :text
      add :quantidade, :integer
      add :preco, :float

      timestamps()
    end
  end
end
