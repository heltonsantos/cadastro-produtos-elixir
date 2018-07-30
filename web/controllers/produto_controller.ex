defmodule CadastroProdutosElix.ProdutoController do
  use CadastroProdutosElix.Web, :controller

  alias CadastroProdutosElix.Produto
  alias CadastroProdutosElix.RedisComponent
  alias CadastroProdutosElix.ElasticsearchComponent


  def index(conn, params) do

    produtos =
      params
      |> get_in(["query"])
      |> search_products()

    render(conn, "index.html", produtos: produtos)
  end


  defp search_products(query) when query in["", nil], do: Repo.all(Produto)
  defp search_products(query) do
    case ElasticsearchComponent.get("produtos_development", query) do
      { :ok, _status, %{hits: %{hits: produtos}} } ->
        produtos
        |> Enum.map(fn %{_id: id, _source: attributes} ->
          Produto
          |> struct(Map.put(attributes, :_id, id))
        end)
    end
  end

  def new(conn, _params) do
    changeset = Produto.changeset(%Produto{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"produto" => produto_params}) do
    changeset = Produto.changeset(%Produto{}, produto_params)

    case Repo.insert(changeset) do
      {:ok, produto} ->
        ElasticsearchComponent.put("produtos_development", "produto", produto._id, produto_params)

        conn
        |> put_flash(:info, "Produto created successfully.")
        |> redirect(to: produto_path(conn, :show, produto))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
   
    case RedisComponent.getCache("produto:"<>id) do  
      :undefined ->
        produto = Repo.get!(Produto, id)
        RedisComponent.setCache("produto:"<>id, Poison.encode!(produto))
      cache ->
        produto = Poison.decode!(cache,  as: %Produto{}) 
    end
    render(conn, "show.html", produto: produto)

  end

  def edit(conn, %{"id" => id}) do
    produto = Repo.get!(Produto, id)
    changeset = Produto.changeset(produto)
    render(conn, "edit.html", produto: produto, changeset: changeset)
  end

  def update(conn, %{"id" => id, "produto" => produto_params}) do

    produto = Repo.get!(Produto, id)
    changeset = Produto.changeset(produto, produto_params)

    case Repo.update(changeset) do
      {:ok, produto} ->
        RedisComponent.setCache("produto:"<>id, Poison.encode!(produto))
        ElasticsearchComponent.put("produtos_development", "produto", produto._id, produto_params)
      
        conn
        |> put_flash(:info, "Produto updated successfully.")
        |> redirect(to: produto_path(conn, :show, produto))
      {:error, changeset} ->
        render(conn, "edit.html", produto: produto, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do

    produto = Repo.get!(Produto, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(produto)
    RedisComponent.delCache("produto:"<>id)
    ElasticsearchComponent.del("produtos_development", "produto", id)

    conn
    |> put_flash(:info, "Produto deleted successfully.")
    |> redirect(to: produto_path(conn, :index))
  end
end
