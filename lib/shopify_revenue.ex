defmodule ShopifyRevenue do
    HTTPoison.start

    def main do
        HTTPoison.get!("https://shopicruit.myshopify.com/admin/orders.json?limit=250&fields=total_price&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        |> decode_json
        |> extract_list
        |> IO.inspect

    end

    def extract_list(map) do
        Map.fetch!(map, "orders")
    end

    def decode_json(%HTTPoison.Response{body: body, status_code: 200}) do
        Poison.Parser.parse!(body)
    end

end