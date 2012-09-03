module Kernel
  def self.const_lookup(const_reference)
    segments = const_reference.split('::')
    const = self
    until segments.empty?
      const = const.const_get(segments.shift)
    end
    const
  end
end
