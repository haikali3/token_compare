require "httparty"

class CryptosController < ApplicationController
  def index
    response = HTTParty.get("https://api.coingecko.com/api/v3/coins/markets", query: {
      vs_currency: "usd",
      order: "market_cap_desc",
      per_page: 10,
      page: 1
    })
    @cryptos = JSON.parse(response.body)

    @bitcoin_prices = []

    market_chart_response = HTTParty.get("https://api.coingecko.com/api/v3/coins/bitcoin/market_chart", query: {
      vs_currency: "usd",
      days: 5,
      interval: "daily"
    })

    if market_chart_response.code == 200
      market_chart_data = market_chart_response.parsed_response

      # format data for chart
      @bitcoin_prices = market_chart_data["prices"].map do |price_data|
        [ Time.at(price_data[0] / 1000).strftime("%Y-%m-%d"), price_data[1] ]
      end
    else
      @error = "Error fetching data"
    end
  end
end
