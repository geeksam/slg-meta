module SLG
  module Meta
    module MethodBondage
      def self.trace!(traced_method)
        target = target_for_eval(traced_method)
        unbound_method = target.instance_method(traced_method.method)
        m = traced_method.method
        target.module_eval do
          define_method(m) do |*args, &b|
            traced_method.called!
            unbound_method.bind(self).call(*args, &b)
          end
        end
      end

      def self.stop_tracing!(traced_method)
        puts "TODO: #{self}.stop_tracing!"
      end

      private

      def self.target_for_eval(traced_method)
        target = traced_method.target
        target = target.metaclass if traced_method.type == :singleton
        target
      end
    end
  end
end
