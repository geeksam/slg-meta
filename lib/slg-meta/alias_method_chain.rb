module SLG
  module Meta
    module AliasMethodChain
      def self.trace!(traced_method)
        m, old_m = names_for_aliasing(traced_method)
        eval_against_appropriate_target(traced_method) do
          alias_method old_m, m
          # NB: this behavior is finicky; see weeble_spec.rb
          define_method(m) do |*args, &b|
            traced_method.called!
            send old_m, *args, &b
          end
        end
      end

      def self.stop_tracing!
        puts "TODO: #{self}.stop_tracing!"
      end

      private

      def self.eval_against_appropriate_target(traced_method, &proc)
        target = traced_method.target
        if traced_method.type == :instance
          target.module_eval(&proc)
        else
          target.meta_eval(&proc)
        end
      end

      def self.names_for_aliasing(traced_method)
        m = traced_method.method
        m_plus = :"#{m}_without_trace"
        return m, m_plus
      end
    end
  end
end
