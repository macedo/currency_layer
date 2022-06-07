# frozen_string_literal: true

require "spec_helper"

RSpec.describe CurrencyLayer::Config do
  subject(:config) { described_class.new }

  describe "sets default parameters" do
    it { expect(config.max_retries).to eql 1 }

    it { expect(config.retry_interval).to eql 0 }
  end
end
