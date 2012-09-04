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

  # NB: these tests are finicky.
  # If they start failing intermittently, it's probably because
  # multiple things are poking around in the Weeble class.
  # It's probably worth the effort to create a new class for each example group.
  it "takes an argument to the class method" do
    expect { Weeble.wobble { raise 'heck' } }.to raise_error
  end

  it "takes an argument to the instance method" do
    expect { Weeble.new.wobble { raise 'kceh' } }.to raise_error
  end
end
