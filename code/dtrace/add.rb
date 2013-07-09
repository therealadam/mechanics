require 'benchmark'

puts Process.pid
print 'Hit ENTER'
gets

Benchmark.bm do |b|

  b.report('Arithmetic') do
    1_000_000.times do
      123 + 456
    end
  end

  b.report('arrays + math') do
    1_000_000.times do
      ary = ["abc", "def", "123", "456"]
      123 + 456
    end
  end

  b.report('a string + math') do
    1_000_000.times do
      "honk!"
      123 + 456
    end
  end

end

