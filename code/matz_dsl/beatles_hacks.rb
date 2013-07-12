BeatlesRuby = Module.new
BeatlesRuby.define_singleton_method(:print) do
  ary = Array.new(4)
  ary[0] = "John"
  ary[1] = "Paul"
  ary[2] = "George"
  ary[4] = "Ringo"

  for b in ary
    puts b
  end
end

BeatlesRuby.print
