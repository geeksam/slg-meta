require 'spec_helper'

describe "SetTraceFunc" do
  subject { SLG::Meta::SetTraceFunc }
  include_context "weebles"
  it_behaves_like "a method tracer"

  it "blithely ignores the difference between instance and singleton methods" do
    subject.trace!(traced_instance_method)
    5.times do
      weeble_class.wobble
      weeble_class.new.wobble
    end
    expect(traced_instance_method.call_count).to eq(10)
  end
end



describe "AliasMethodChain" do
  subject { SLG::Meta::AliasMethodChain }
  include_context "weebles"
  it_behaves_like "a method tracer"
end



describe "MethodBondage" do
  subject { SLG::Meta::MethodBondage }
  include_context "weebles"
  it_behaves_like "a method tracer"
end
