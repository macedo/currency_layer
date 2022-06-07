# frozen_string_literal: true

require "spec_helper"

RSpec.describe CurrencyLayer do
  it "has a version number" do
    expect(CurrencyLayer::VERSION).not_to be_nil
  end

  describe ".live_rates" do
    context "success responses" do
      {
        live_rates_success1: {
          source: "USD",
          currencies: %w[BRL EUR]
        },

        live_rates_success2: {
          source: "BRL",
          currencies: %w[USD]
        }
      }.each do |t, attrs|
        context t do
          subject(:response) do
            VCR.use_cassette(t) do
              CurrencyLayer.live_rates(source: attrs[:source], currencies: attrs[:currencies])
            end
          end

          it { expect(response["success"]).to be_truthy }

          it { expect(response["source"]).to eql attrs[:source] }

          it { expect(response["quotes"].size).to eql attrs[:currencies].size }
        end
      end
    end
  end
end
