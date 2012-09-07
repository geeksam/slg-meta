module SLG
  module Meta
    module MethodBondage
      def self.trace!(traced_method)
        m, ivar = method_and_ivar_names(traced_method)
        eval_against_appropriate_target(traced_method) do
          unbound_method = instance_method(m)
          instance_variable_set(ivar, unbound_method)
          define_method(m) do |*args, &b|
            traced_method.called!
            unbound_method.bind(self).call(*args, &b)
          end
        end
      end

      def self.stop_tracing!(traced_method)
        m, ivar = method_and_ivar_names(traced_method)
        eval_against_appropriate_target(traced_method) do
          unbound_method = instance_variable_get(ivar)
          define_method(m, unbound_method)
        end
      end

      private

      def self.eval_against_appropriate_target(traced_method, &proc)
        target = traced_method.target
        target = target.metaclass if traced_method.type == :singleton
        target.module_eval(&proc)
      end

      def self.method_and_ivar_names(traced_method)
        m = traced_method.method
        ivar = "@__slg_meta__#{m}__unbound_method__"
        return m, ivar
      end
    end
  end
end
