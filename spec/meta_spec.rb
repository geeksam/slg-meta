require 'spec_helper'

Weeble1 = new_weeble_class
Weeble2 = new_weeble_class

describe SLG::Meta do
  subject { SLG:: Meta }

  after(:each) do
    Weeble.wobbles = 0
  end

  it "has a default implementation" do
    expect(subject.default_tracer).to be(SLG::Meta::SetTraceFunc)
  end

  it "sets up a traced method" do
    tm = subject.traced_method('Weeble.wobble')
    expect(tm).to be_kind_of(SLG::Meta::TracedMethod)
    expect(tm.data).to eq([Weeble, :singleton, :wobble])
  end

  it "traces calls to a method using the SetTraceFunc strategy", :integration => true do
    tm = SLG::Meta.trace!('Weeble1.wobble', SLG::Meta::SetTraceFunc)
    5.times { Weeble1.wobble }
    expect(tm.call_count).to eq(5)
    expect(Weeble1.wobbles).to eq(5)
  end

  it "traces calls to a method using the AliasMethodChain strategy", :integration => true do
    tm = SLG::Meta.trace!('Weeble2.wobble', SLG::Meta::AliasMethodChain)
    5.times { Weeble2.wobble }
    expect(tm.call_count).to eq(5)
    expect(Weeble2.wobbles).to eq(5)
  end

  # TODO: stop using the shared Weeble class for this
end
