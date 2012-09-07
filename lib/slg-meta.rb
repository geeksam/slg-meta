require File.join(File.dirname(__FILE__), *%w[requires])

module SLG
  module Meta
    Strategies = {
      :no_tracing         => NullObject,  # useful for breaking specs to prove that they work
      :set_trace_func     => SetTraceFunc,
      :alias_method_chain => AliasMethodChain,
      :method_bondage     => MethodBondage,
    }
    Strategies.default = MethodBondage

    def self.trace!(method_identifier, strategy_name = nil)
      traced_method = TracedMethod.for(method_identifier)
      strategy = Strategies[strategy_name]
      Tracer.trace!(traced_method, strategy)
    rescue TracedMethod::TargetNotDefined
      # TODO: set up callback to add tracing once it is defined
    ensure
      return traced_method
    end

    def self.stop_tracing!(strategy_name = DefaultStrategyName)
      strategy = Strategies[strategy_name]
      Tracer.stop_tracing!(strategy)
    end

    def self.with_tracing(method_identifier, strategy_name = DefaultStrategyName)
      traced_method = trace!(method_identifier, strategy_name)
      yield
      stop_tracing!(strategy_name)
    ensure
      return traced_method
    end
  end
end


# Now that that's all over with, add some support for command-line invocation
require File.join(File.dirname(__FILE__), *%w[command_line_support])
