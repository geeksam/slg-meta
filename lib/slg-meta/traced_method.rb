require 'thread'

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

      def woss_name
        base.to_s
      end

      def called!
        mutex.synchronize do
          # Using the verbose version to facilitate testing
          n = @call_count
          yield if block_given?
          @call_count = n + 1
        end
      end

      def to_s
        separator = type == :instance ? '#' : '.'
        [base, separator, method].join
      end

      private

      def mutex
        @mutex ||= Mutex.new
      end
    end
  end
end
