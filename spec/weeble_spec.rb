require 'spec_helper'

describe "Weeble class" do
  let(:wobbler) { Weeble }
  it_behaves_like "a wobbler"
end
describe "a Weeble instance" do
  let(:wobbler) { Weeble.new }
  it_behaves_like "a wobbler"
end
