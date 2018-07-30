defmodule CadastroProdutosElix.PageController do
  use CadastroProdutosElix.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
