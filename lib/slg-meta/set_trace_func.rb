module SLG
  module Meta
    module SetTraceFunc
      def self.trace(method_id_string)
        @traced_method = TracedMethod.new(method_id_string)
      end

      def self.traced_thing
        @traced_method.to_a
      end
    end
  end
end
