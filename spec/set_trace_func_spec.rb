require 'spec_helper'

describe "using set_trace_func" do
  subject { SLG::Meta::SetTraceFunc }
  let(:traced_method) {
    SLG::Meta::TracedMethod.for_method('Weeble#wobble')
  }

  it "traces calls to a method" do
    traced_method.should_receive(:called!).exactly(10).times
    subject.trace!(traced_method)
    10.times do
      # SpecTargets::ForSetTraceFunc.new.foo
      Weeble.new.wobble
    end
  end
end
