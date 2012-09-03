require 'spec_helper'

module Base64
end
module ActiveRecord
  class Base
  end
end

describe "using set_trace_func" do
  subject { SLG::Meta::SetTraceFunc }

  describe "Figuring out what to trace" do
    it "groks String#size" do
      subject.trace 'String#size'
      expect(subject.traced_thing).to eq([String, :instance, :size])
    end

    it "groks Array#map!" do
      subject.trace 'Array#map!'
      expect(subject.traced_thing).to eq([Array, :instance, :map!])
    end

    it "groks ActiveRecord::Base#find" do
      subject.trace 'ActiveRecord::Base#find'
      expect(subject.traced_thing).to eq([ActiveRecord::Base, :instance, :find])
    end

    it "groks Base64.encode64" do
      subject.trace 'Base64.encode64'
      expect(subject.traced_thing).to eq([Base64, :singleton, :encode64])
    end
  end

  it "actually traces"
end
