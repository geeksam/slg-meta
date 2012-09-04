require 'spec_helper'

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

  it "traces calls to a method *and actually calls that method*", :integration => true do
    tm = SLG::Meta.trace!('Weeble.wobble', SLG::Meta::SetTraceFunc)
    5.times do
      Weeble.wobble
    end
    expect(tm.call_count).to eq(5)
    expect(Weeble.wobbles).to eq(5)
  end
end
