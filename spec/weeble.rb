class Weeble
  def self.wobbles
    @wobbles ||= 0
  end
  def self.wobbles=(value)
    @wobbles = value
  end
  def self.wobble
    self.wobbles += 1
  end
  def wobble
  end
end
