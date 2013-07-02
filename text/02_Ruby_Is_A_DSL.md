# Ruby is a DSL, for Matz

When I was learning Ruby, many years ago, it struck me how many parallels there
were between the C implementation of the Ruby language and what the Ruby
language itself looks like. You can play this similarity out to unify Ruby and
its canonical implementation: Ruby is a DSL that Matz wrote for himself so he
can write C code in his own idiomatic style without having to worry about many
of the concerns of writing C code.

Consider this simple Ruby program:

@@@ ruby dsl/beatles_ruby.rb @@@

Here it is, implemented as a C extension to Ruby:

@@@ ruby dsl/ext/beatles.c @@@

Honey. I exploded the Ruby code. Look at all of it! Turns out, there's a bit
going on when we write even the simplest Ruby. But it's super interesting, as
a prankster scientist, to look at what's going on.

There's a module definition and a method definition. We create an array; to
call `Kernel.puts` we have to get a reference to the module, a reference to the
method, and then pass an array of arguments. We use almost entirely Ruby
constructs, rather than C constructs.

And what's that `VALUE` thing. In C terms, it's a long pointer. In Ruby terms,
it's any old object.

