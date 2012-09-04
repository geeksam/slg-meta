module SLG
  module Meta
    module AliasMethodChain
      def self.trace!(traced_method)
        alias_and_trace = lambda do
          m = traced_method.method
          old_m = :"#{m}_without_trace"
          alias_method old_m, m
          # NB: this behavior is finicky; see weeble_spec.rb
          define_method(m) do |*args, &b|
            traced_method.called!
            send old_m, *args, &b
          end
        end

        target = traced_method.base
        if traced_method.type == :instance
          target.module_eval(&alias_and_trace)
        else
          target.meta_eval(&alias_and_trace)
        end
      end
    end
  end
end
