require 'benchmark'
require File.join(File.dirname(__FILE__), *%w[.. lib slg-meta])

class McTesterson
  def self.testy
  end

  def self.testaroonie
  end
end

n = 100_000

Benchmark.bmbm do |x|
  foo = x.report("no tracing") do
    n.times { McTesterson.testy }
  end
  strategies = [:set_trace_func]  # TODO: implement stop_tracing! for strategies before adding them here
  strategies.each do |strategy|
    x.report("#{strategy}, calling a traced method") do
      SLG::Meta.with_tracing('McTesterson.testy', strategy) do
        n.times { McTesterson.testy }
      end
    end
    x.report("#{strategy}, calling an untraced method") do
      SLG::Meta.with_tracing('McTesterson.testy', strategy) do
        n.times { McTesterson.testaroonie }
      end
    end
  end
end
