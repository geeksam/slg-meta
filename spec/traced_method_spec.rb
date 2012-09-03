require 'spec_helper'

module Base64
end
module ActiveRecord
  class Base
  end
end

describe SLG::Meta::TracedMethod do
  def trace(method_identifier)
    SLG::Meta::TracedMethod.for_method(method_identifier)
  end
  def trace_data(method_identifier)
    trace(method_identifier).to_a
  end
  subject { trace('String#size') }

  describe "parsing method identifiers" do
    it "groks String#size" do
      expect(trace_data 'String#size').to \
        eq([String, :instance, :size])
    end

    it "groks Array#map!" do
      expect(trace_data 'Array#map!').to \
        eq([Array, :instance, :map!])
    end

    it "groks ActiveRecord::Base#find" do
      expect(trace_data 'ActiveRecord::Base#find').to \
        eq([ActiveRecord::Base, :instance, :find])
    end

    it "groks Base64.encode64" do
      expect(trace_data 'Base64.encode64').to \
        eq([Base64, :singleton, :encode64])
    end

    it "eats whitespace" do
      expect(trace_data '  Base64  . encode64 ').to \
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
    end

    it "is threadsafe"
  end
end
