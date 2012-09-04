require 'spec_helper'

describe "using set_trace_func" do
  subject { SLG::Meta::SetTraceFunc }
  let(:traced_method) { SLG::Meta::TracedMethod.for('Weeble#wobble') }

  it "traces calls to a method" do
    traced_method.should_receive(:called!).exactly(10).times
    subject.trace!(traced_method)
    10.times do
      Weeble.wobble
    end
  end

  it "traces calls to a method, blithely ignoring the difference between instance and singleton methods", :integration => true do
    subject.trace!(traced_method)
    5.times do
      Weeble.wobble
      Weeble.new.wobble
    end
    expect(traced_method.call_count).to eq(10)
  end
end
