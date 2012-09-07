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
      strategy = Strategies[strategy_name]
      traced_method = TracedMethod.for(method_identifier)
      strategy.trace!(traced_method)
    rescue TracedMethod::TargetNotDefined
      # TODO: set up callback to add tracing once it is defined
    ensure
      return traced_method
    end

    # TODO: keep track of current strategy, so more than one is not active at the same time?
    def self.stop_tracing!(method_identifier, strategy_name = nil)
      strategy = Strategies[strategy_name]
      traced_method = TracedMethod.for(method_identifier)
      strategy.stop_tracing!(traced_method)
    ensure
      return traced_method
    end

    def self.with_tracing(method_identifier, strategy_name = nil)
      traced_method = trace!(method_identifier, strategy_name)
      yield
      stop_tracing!(method_identifier, strategy_name)
    ensure
      return traced_method
    end
  end
end


# Now that that's all over with, add some support for command-line invocation
require File.join(File.dirname(__FILE__), *%w[command_line_support])
