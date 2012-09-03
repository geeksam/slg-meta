module SLG
  module Meta
    class TracedMethod
      attr_reader :base, :method, :type

      def self.trace(method_id_string)
        new(method_id_string)
      end

      def initialize(method_id_string)
        method_id_string =~ /(.*)([#\.])(.*)/
        base, type, method = $1, $2, $3
        @base   = Kernel.const_lookup(base)
        @type   = type == '#' ? :instance : :singleton
        @method = method.to_sym
      end

      def to_a
        [base, type, method]
      end
    end
  end
end
