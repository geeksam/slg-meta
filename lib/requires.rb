# Require ALL the things
require 'pathname'

lib = Pathname.new(File.join(File.dirname(__FILE__), 'slg-meta'))
libfiles = Dir.glob(lib + '*.rb').map { |e| File.basename(e).gsub(/\.rb$/, '') }
libfiles.each do |libfile|
  require lib + libfile
end
