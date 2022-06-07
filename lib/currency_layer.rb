# frozen_string_literal: true

require "faraday"
require_relative "currency_layer/config"
require_relative "currency_layer/version"

module CurrencyLayer
  class Error < StandardError; end
  # Your code goes here...

  class << self
    attr_writer :config, :connection
  end

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
  end

  def self.connection
    @connection ||= Faraday.new(
      url: "https://api.currencylayer.com",
      params: { access_key: config.access_key }
    ) do |conn|
      conn.response :json
    end
  end

  def self.live_rates(source: "USD", currencies: [])
    response = connection.get("/live", { source: source, currencies: currencies.join(",") })
    response.body
  end
end
