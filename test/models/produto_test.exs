defmodule CadastroProdutosElix.ProdutoTest do
  use CadastroProdutosElix.ModelCase

  alias CadastroProdutosElix.Produto

  @valid_attrs %{descricao: "some descricao", nome: "some nome", preco: 120.5, quantidade: 42, sku: "some sku"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Produto.changeset(%Produto{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Produto.changeset(%Produto{}, @invalid_attrs)
    refute changeset.valid?
  end
end
