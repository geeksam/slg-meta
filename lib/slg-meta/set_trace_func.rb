module SLG
  module Meta
    module SetTraceFunc
      def self.trace!(traced_method)
        # This doesn't appear to differentiate between class methods
        # and instance methods.  WTF, Ruby?
        # And let's not even talk about string comparisons here, really
        Kernel.set_trace_func proc { |event, file, line, id, binding, class_name|
          next if event != 'call'
          next if class_name.to_s != traced_method.target_name
          next if id.to_sym != traced_method.method
          traced_method.called!
        }
      end

      def self.stop_tracing!
        Kernel.set_trace_func(nil)
      end
    end
  end
end
