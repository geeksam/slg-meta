require 'spec_helper'

describe "AliasMethodChain" do
  subject { SLG::Meta::AliasMethodChain }
  include_context "weebles"
  it_behaves_like "a method tracer"
end
