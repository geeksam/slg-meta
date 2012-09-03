require 'pathname'
lib = Pathname.new(File.join(File.dirname(__FILE__), 'slg-meta'))

require lib + 'version'
require lib + 'core_ext'
require lib + 'traced_method'
require lib + 'set_trace_func'

module SLG
  module Meta
  end
end
