def new_weeble_class
  Class.new do
    # TODO: find a clever way to DRY this up
    def self.wobbles
      @wobbles ||= 0
    end
    def self.wobbles=(value)
      @wobbles = value
    end
    def self.wobble
      yield if block_given?
      self.wobbles += 1
    end

    def wobbles
      @wobbles ||= 0
    end
    def wobbles=(value)
      @wobbles = value
    end
    def wobble
      yield if block_given?
      self.wobbles += 1
    end
  end
end

Weeble = new_weeble_class
