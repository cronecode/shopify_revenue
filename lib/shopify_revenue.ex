defmodule ShopifyRevenue do
    HTTPoison.start

    def main do
        HTTPoison.get!("https://shopicruit.myshopify.com/admin/orders.json?limit=250&fields=total_price&access_token=c32313df0d0ef512ca64d5b336a0d7c6")
        |> decode_json
        |> extract_list
        |> convert_price_strings
        |> count_money

    end

    def count_money(prices) do
        n = Enum.count(prices)
        total = Enum.sum(prices)

        rounded_total = Float.round(total, 2)

        IO.puts "You've made $#{Float.to_string(rounded_total)} from #{Integer.to_string(n)} orders"
    end

    def convert_price_strings(list) do
        for %{"total_price" => v} <- list, do: String.to_float(v)
    end

    def extract_list(map) do
        Map.fetch!(map, "orders")
    end

    def decode_json(%HTTPoison.Response{body: body, status_code: 200}) do
        Poison.Parser.parse!(body)
    end

end