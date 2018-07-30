defmodule CadastroProdutosElix.ProdutoControllerTest do
  use CadastroProdutosElix.ConnCase

  alias CadastroProdutosElix.Produto
  @valid_attrs %{descricao: "some descricao", nome: "some nome", preco: 120.5, quantidade: 42, sku: "some sku"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, produto_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing produtos"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, produto_path(conn, :new)
    assert html_response(conn, 200) =~ "New produto"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, produto_path(conn, :create), produto: @valid_attrs
    produto = Repo.get_by!(Produto, @valid_attrs)
    assert redirected_to(conn) == produto_path(conn, :show, produto.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, produto_path(conn, :create), produto: @invalid_attrs
    assert html_response(conn, 200) =~ "New produto"
  end

  test "shows chosen resource", %{conn: conn} do
    produto = Repo.insert! %Produto{}
    conn = get conn, produto_path(conn, :show, produto)
    assert html_response(conn, 200) =~ "Show produto"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, produto_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    produto = Repo.insert! %Produto{}
    conn = get conn, produto_path(conn, :edit, produto)
    assert html_response(conn, 200) =~ "Edit produto"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    produto = Repo.insert! %Produto{}
    conn = put conn, produto_path(conn, :update, produto), produto: @valid_attrs
    assert redirected_to(conn) == produto_path(conn, :show, produto)
    assert Repo.get_by(Produto, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    produto = Repo.insert! %Produto{}
    conn = put conn, produto_path(conn, :update, produto), produto: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit produto"
  end

  test "deletes chosen resource", %{conn: conn} do
    produto = Repo.insert! %Produto{}
    conn = delete conn, produto_path(conn, :delete, produto)
    assert redirected_to(conn) == produto_path(conn, :index)
    refute Repo.get(Produto, produto.id)
  end
end
