module SLG
  module Meta
    module Tracer
      def self.default_strategy
        @default_strategy ||= MethodBondage
      end

      def self.default_strategy=(strategy)
        @default_strategy = strategy
      end

      def self.trace!(traced_method, strategy = nil)
        strategy ||= default_strategy
        strategy.trace!(traced_method)
      end

      def self.stop_tracing!(strategy = nil)
        strategy ||= default_strategy
        strategy.stop_tracing!
      end
    end
  end
end
