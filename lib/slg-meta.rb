require File.join(File.dirname(__FILE__), *%w[requires])

module SLG
  module Meta
    def self.trace!(method_identifier, strategy = nil)
      traced_method = TracedMethod.for(method_identifier)
      Tracer.trace!(traced_method, strategy)
      return traced_method
    end
  end
end


# Now that that's all over with, add some support for command-line invocation
require File.join(File.dirname(__FILE__), *%w[command_line_support])
