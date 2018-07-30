defmodule CadastroProdutosElix.Produto do
  use CadastroProdutosElix.Web, :model

  # see the note below for explanation of that line
  @primary_key {:_id, :binary_id, autogenerate: true}
  @derive {Poison.Encoder, only: [:_id, :sku, :nome, :descricao, :quantidade, :preco]}
  @derive {Poison.Decoder, only: [:_id, :sku, :nome, :descricao, :quantidade, :preco]}
  @timestamps_opts [inserted_at: :created_at]
  @derive {Phoenix.Param, key: :_id}
  schema "produtos" do
    field :sku, :string
    field :nome, :string
    field :descricao, :string
    field :quantidade, :integer
    field :preco, :float

    timestamps()

  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:sku, :nome, :descricao, :quantidade, :preco])
    |> validate_required([:sku, :nome, :descricao, :quantidade, :preco])
  end
end
