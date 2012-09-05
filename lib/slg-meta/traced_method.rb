require 'thread'

module SLG
  module Meta
    class TracedMethod
      attr_reader :base_name, :method, :type, :call_count

      def self.for(method_id_string)
        md = /(.*)([#\.])(.*)/.match(method_id_string)
        base_name = md.captures[0].gsub(/\s+/, '')
        type      = md.captures[1] == '#' ? :instance : :singleton
        method    = md.captures[2].strip.to_sym
        new(base_name, type, method)
      end

      def initialize(base, type, method)
        @base = base unless base.kind_of?(String) # allow setting class directly (facilitates testing)
        @base_name = base.to_s
        @type = type
        @method = method
        @call_count = 0
      end

      def base
        @base ||= Kernel.const_lookup(base_name)
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
        [base_name, separator, method].join
      end

      private

      def mutex
        @mutex ||= Mutex.new
      end
    end
  end
end
