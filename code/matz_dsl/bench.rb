require 'benchmark/ips'
require './beatles_ruby'
require './ext/beatles'

BeatlesRuby.print
Beatles.print

Benchmark.ips do |x|

  x.report('ruby') { BeatlesRuby.print }
  x.report('c') { Beatles.print }

end

