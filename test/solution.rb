require 'pathname'
TestPath = Pathname.new(File.dirname(__FILE__))
LibPath  = Pathname.new(File.expand_path(TestPath + '../lib'))
$: << LibPath.to_s
require 'slg-meta'
