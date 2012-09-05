require 'pathname'
SpecPath = Pathname.new(File.dirname(__FILE__))
LibPath  = Pathname.new(File.expand_path(SpecPath + '../lib'))
$: << LibPath.to_s
require 'slg-meta'
require SpecPath + 'weeble'
require SpecPath + 'shared/wobblers'
require SpecPath + 'shared/method_tracer'