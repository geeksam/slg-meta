require 'spec_helper'

describe "acceptance criteria" do
  def ruby_output(method_identifier, ruby_string)
    `COUNT_CALLS_TO='#{method_identifier}' ruby -r '#{LibPath + 'slg-meta.rb'}' -e '#{ruby_string}'`
  end

  it "works with ruby -e" do
    output = ruby_output('String#size', '(1..100).each{|i| i.to_s.size if i.odd? }')
    output.strip.should == 'String#size called 50 times'
  end

  it "passes the more complex example" do
    output = ruby_output('B#foo', 'module A; def foo; end; end; class B; include A; end; 10.times{B.new.foo}')
    output.strip.should == 'B#foo called 10 times'
  end
end
