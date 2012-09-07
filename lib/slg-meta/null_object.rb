class NullObject
  instance_methods.each { |meth| undef_method(meth) unless meth =~ /\A__/ }
  def method_missing(meth, *args, &block)
    self
  end
end
