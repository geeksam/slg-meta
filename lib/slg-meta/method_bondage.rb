module SLG
  module Meta
    module MethodBondage
      def self.trace!(traced_method)
        if traced_method.type == :instance
          target = traced_method.base
        else
          target = traced_method.base.metaclass
        end
        jiggery_pokery = method_jiggery_pokery(target, traced_method)
        target.module_eval(&jiggery_pokery)
      end

      private

      def self.method_jiggery_pokery(target, traced_method)
        unbound_method = target.instance_method(traced_method.method)
        lambda do
          m = traced_method.method
          define_method(m) do |*args, &b|
            traced_method.called!
            unbound_method.bind(self).call(*args, &b)
          end
        end
      end
    end
  end
end
