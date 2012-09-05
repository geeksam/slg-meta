module SLG
  module Meta
    module Tracer
      def self.default_strategy
        @default_strategy ||= MethodBondage
      end

      def self.default_strategy=(strategy)
        @default_strategy = strategy
      end

      def self.trace!(traced_method, strategy = default_strategy)
        strategy.trace!(traced_method)
      end
    end
  end
end
