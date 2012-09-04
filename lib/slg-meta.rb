require 'pathname'
lib = Pathname.new(File.join(File.dirname(__FILE__), 'slg-meta'))

require lib + 'version'
require lib + 'core_ext'
require lib + 'traced_method'
require lib + 'alias_method_chain'
require lib + 'set_trace_func'

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
