require File.join(File.dirname(__FILE__), *%w[requires])

module SLG
  module Meta
    def self.default_tracer
      @default_tracer ||= SetTraceFunc
    end

    def self.default_tracer=(tracer)
      @default_tracer = tracer
    end

    def self.traced_method(method_identifier)
      TracedMethod.for(method_identifier)
    end

    def self.trace!(method_identifier, tracer = default_tracer)
      tm = traced_method(method_identifier)
      tracer.trace!(tm)
      tm
    end
  end
end
