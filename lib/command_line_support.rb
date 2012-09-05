method_identifier = ENV['COUNT_CALLS_TO']
if method_identifier =~ /\S+/
  traced_method = SLG::Meta.trace!(method_identifier)
  Kernel.at_exit do
    n = traced_method.call_count
    times = n == 1 ? 'time' : 'times'
    puts "#{traced_method} called #{n} #{times}"
  end
end