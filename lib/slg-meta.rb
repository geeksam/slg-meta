require File.join(File.dirname(__FILE__), *%w[requires])

module SLG
  module Meta
    def self.traced_method(method_identifier)
      TracedMethod.for(method_identifier)
    end

    def self.default_strategy
      Tracer.default_strategy
    end

    def self.default_strategy=(strategy)
      Tracer.default_strategy
    end

    def self.trace!(method_identifier, strategy = default_strategy)
      traced_method(method_identifier).tap do |tm|
        Tracer.trace!(tm)
      end
    end
  end
end


# Now that that's all over with, add some support for command-line invocation
require File.join(File.dirname(__FILE__), *%w[command_line_support])
