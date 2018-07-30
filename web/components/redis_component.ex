defmodule CadastroProdutosElix.RedisComponent do

	def getCache(key) do
		{:ok, client} = Exredis.start_link
		cache = Exredis.Api.get(client, key)
		client |> Exredis.stop
		cache
	end

	def setCache(key, value) do
		{:ok, client} = Exredis.start_link
		Exredis.Api.set(client, key, value)
		client |> Exredis.stop
	end

	def delCache(key) do
		{:ok, client} = Exredis.start_link
		Exredis.Api.del(client, key)
		client |> Exredis.stop
	end


end	