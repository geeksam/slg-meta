require 'pathname'
spec_path = Pathname.new(File.dirname(__FILE__))
lib_path  = Pathname.new(File.expand_path(spec_path + '../lib'))
$: << lib_path.to_s
require 'slg-meta'
require spec_path + 'weeble'