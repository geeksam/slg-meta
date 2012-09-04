require 'spec_helper'

# Stub out things referred to in the tests
module Base64
end
module ActiveRecord
  class Base
  end
end

describe SLG::Meta::TracedMethod do
  def trace(method_identifier)
    SLG::Meta::TracedMethod.for(method_identifier)
  end

  subject { trace('String#size') }

  describe "parsing method identifiers" do
    it "groks String#size" do
      expect(trace('String#size').data).to \
        eq([String, :instance, :size])
    end

    it "groks Array#map!" do
      expect(trace('Array#map!').data).to \
        eq([Array, :instance, :map!])
    end

    it "groks ActiveRecord::Base#find" do
      expect(trace('ActiveRecord::Base#find').data).to \
        eq([ActiveRecord::Base, :instance, :find])
    end

    it "groks Base64.encode64" do
      expect(trace('Base64.encode64').data).to \
        eq([Base64, :singleton, :encode64])
    end

    it "eats whitespace" do
      expect(trace('  Base64  . encode64 ').data).to \
        eq([Base64, :singleton, :encode64])
    end
  end

  it "has a #woss_name method (which should be #class_name, but rspec sends that on a failure and barfs all over itself)" do
    tm = trace('ActiveRecord::Base#find')
    expect(tm.woss_name).to eq('ActiveRecord::Base')
  end

  describe "#called!" do
    it "increments #call_count" do
      3.times { subject.called! }
      expect(subject.call_count).to eq(3)
      subject.called!
      expect(subject.call_count).to eq(4)
    end

    it "is threadsafe"
  end
end
