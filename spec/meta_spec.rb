require 'spec_helper'

shared_examples "a method tracing strategy" do |weeble_class, strategy|
  it "traces calls to a method using the #{strategy} strategy", :integration => true do
    tm = SLG::Meta.trace!("#{weeble_class}.wobble", strategy)
    5.times { weeble_class.wobble }
    expect(tm.call_count).to eq(5)
    expect(weeble_class.wobbles).to eq(5)
  end
end

describe SLG::Meta do
  subject { SLG:: Meta }

  after(:each) do
    Weeble.wobbles = 0
  end

  # Integration specs for the various strategies

  Weeble1 = new_weeble_class
  it_behaves_like "a method tracing strategy", Weeble1, SLG::Meta::SetTraceFunc

  Weeble2 = new_weeble_class
  it_behaves_like "a method tracing strategy", Weeble2, SLG::Meta::AliasMethodChain

  Weeble3 = new_weeble_class
  it_behaves_like "a method tracing strategy", Weeble3, SLG::Meta::MethodBondage
end
