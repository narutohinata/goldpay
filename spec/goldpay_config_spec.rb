require 'spec_helper'

RSpec.describe Goldpay do
  it "return true configure" do
    Goldpay.configure do |config|
      config.private_key = "private_key"
      config.public_key  = "public_key"
    end

    expect(Goldpay.config.private_key) == "private_key"
  end
end