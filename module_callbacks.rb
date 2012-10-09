class Module
  def singleton_method_added(id)
    puts "#{self}.singleton_method_added(#{id.inspect})"
  end
  def method_added(id)
    puts "#{self}.method_added(#{id.inspect})"
  end
end

puts ''

class Object
  # def self.inherited(*args)
  #   puts "#{self}.inherited: #{args.map(&:inspect).join(', ')}"
  # end
end

puts ''

class Foo
  def self.self_foo
  end
  def instance_foo
  end
end

puts ''

class FooFoo < Foo
  def self.self_foofoo
  end
  def instance_foofoo
  end
end

puts ''

module YakShaveable
  def self.self_yak
  end
  def instance_yak
  end
end
