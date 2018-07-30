defmodule CadastroProdutosElix.ElasticsearchComponent do
	import Tirexs.HTTP

	def get(index, query) do
		get("/"<>index<>"/_search?q="<>query)
	end

	def put(index, type, id, value) do
		put("/"<>index<>"/"<>type<>"/"<>id, value)
	end

	def del(index, type, id) do
		delete("/"<>index<>"/"<>type<>"/"<>id)
	end

end	