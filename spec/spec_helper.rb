require 'pathname'
spec_path = Pathname.new(File.dirname(__FILE__))
lib_path  = Pathname.new(File.expand_path(spec_path + '../lib'))
$: << lib_path.to_s
require 'slg-meta'
require spec_path + 'weeble'
require spec_path + 'shared/wobblers'
require spec_path + 'shared/method_tracer'