# frozen_string_literal: true

module CurrencyLayer
  class Config
    attr_accessor :access_key, :max_retries, :retry_interval

    def initialize
      @max_retries = 1
      @retry_interval = 0
    end
  end
end
