require 'spec_helper'

describe "SetTraceFunc" do
  subject { SLG::Meta::SetTraceFunc }

  it_behaves_like "an instance method tracer"
  it_behaves_like "a singleton method tracer"

  # I don't see a workaround for this bug, so let's just call it a feature
  include_context "wobblers"
  let(:traced_method) { SLG::Meta::TracedMethod.new(wobbler_class, :instance,  :wobble) }
  it "blithely ignores the difference between instance and singleton methods" do
    subject.trace!(traced_method)
    5.times do
      wobbler_class.wobble
      wobbler_instance.wobble
    end
    expect(traced_method.call_count).to eq(10)
  end
end



describe "AliasMethodChain" do
  subject { SLG::Meta::AliasMethodChain }
  it_behaves_like "an instance method tracer"
  it_behaves_like "a singleton method tracer"
end



describe "MethodBondage" do
  subject { SLG::Meta::MethodBondage }
  it_behaves_like "an instance method tracer"
  it_behaves_like "a singleton method tracer"
end
