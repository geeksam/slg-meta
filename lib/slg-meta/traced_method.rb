require 'thread'

module SLG
  module Meta
    class TracedMethod
      attr_reader :target_name, :method, :type, :call_count

      def self.for(method_id_string)
        md = /(.*)([#\.])(.*)/.match(method_id_string)
        target_name = md.captures[0].gsub(/\s+/, '')
        type        = md.captures[1] == '#' ? :instance : :singleton
        method      = md.captures[2].strip.to_sym
        new(target_name, type, method)
      end

      def initialize(target, type, method)
        @target = target unless target.kind_of?(String) # allow setting class directly (facilitates testing)
        @target_name = target.to_s
        @type = type
        @method = method
        @call_count = 0
      end

      def target
        @target ||= Kernel.const_lookup(target_name)
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
        [target_name, separator, method].join
      end

      private

      def mutex
        @mutex ||= Mutex.new
      end
    end
  end
end
