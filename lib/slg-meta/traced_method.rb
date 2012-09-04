module SLG
  module Meta
    class TracedMethod
      attr_reader :base, :method, :type, :call_count

      def self.for(method_id_string)
        method_id_string =~ /(.*)([#\.])(.*)/
        base, type, method = $1.strip, $2, $3.strip
        base   = Kernel.const_lookup(base)
        type   = type == '#' ? :instance : :singleton
        method = method.to_sym
        new(base, type, method)
      end

      def initialize(base, type, method)
        @base, @type, @method = base, type, method
        @call_count = 0
      end

      def data
        [base, type, method]
      end

      def woss_name
        base.to_s
      end

      # TODO: consider mutexing this for thread safety
      def called!
        @call_count += 1
      end
    end
  end
end
