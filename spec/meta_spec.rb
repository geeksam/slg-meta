require 'spec_helper'

shared_examples "a method tracing strategy" do |weeble_class, strategy|
  it "traces calls to a method using the #{strategy} strategy", :integration => true do
    traced_method = SLG::Meta.with_tracing("#{weeble_class}.wobble", strategy) do
      5.times { weeble_class.wobble }
    end
    weeble_class.wobble # this should not be traced!
    expect(traced_method.call_count).to eq(5)
    expect(weeble_class.wobbles).to eq(6)
  end
end

describe SLG::Meta do
  subject(:meta) { SLG::Meta }

  describe "callback registration for tracing methods not yet defined" do
    it "keeps track of it for later" do
      meta.trace!('Foo#foo')
      expect(meta.traced_methods.map(&:to_s)).to include('Foo#foo')
    end

    it "actually adds tracing later, when the method is defined" do
      traced_method = meta.trace!('YakShaversRUs#shave_that_yak!')
      class YakShaversRUs
        def shave_that_yak!
        end
      end
      yak = YakShaversRUs.new
      3.times { yak.shave_that_yak! }
      expect(traced_method.call_count).to eq(3)
    end
  end

  # Integration specs for the various strategies

  describe "set_trace_func strategy" do
    Weeble1 = new_weeble_class
    it_behaves_like "a method tracing strategy", Weeble1, :set_trace_func
  end

  describe "alias_method_chain strategy" do
    Weeble2 = new_weeble_class
    it_behaves_like "a method tracing strategy", Weeble2, :alias_method_chain
  end

  describe "method_bondage strategy" do
    Weeble3 = new_weeble_class
    it_behaves_like "a method tracing strategy", Weeble3, :method_bondage
  end
end
