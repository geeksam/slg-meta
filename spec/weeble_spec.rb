require 'spec_helper'

describe Weeble do
  before(:each) do
    Weeble.wobbles = 0
  end

  it "has a count of wobbles" do
    expect(Weeble.wobbles).to eq(0)
    Weeble.wobble
    expect(Weeble.wobbles).to eq(1)
    Weeble.wobble
    expect(Weeble.wobbles).to eq(2)
    Weeble.wobbles = 0
    expect(Weeble.wobbles).to eq(0)
  end
end
