require "spec_helper"

RSpec.describe Goldpay::Utils do
  it "will return stringify hash" do
    old_hash = {:name => "哈哈", :age => 21}
    new_hash = Goldpay::Utils.stringify_keys(old_hash)
    expect(new_hash) == {name: "哈哈", age: 21}
  end

  it "should reuten a rand number" do
    p Goldpay::Utils::generate_batch_no
  end
end