# Ruby is a DSL, for Matz

When I was learning Ruby, many years ago, it struck me how many parallels there
were between the C implementation of the Ruby language and what the Ruby
language itself looks like. You can play this similarity out to unify Ruby and
its canonical implementation: Ruby is a DSL that Matz wrote for himself so he
can write C code in his own idiomatic style without having to worry about many
of the concerns of writing C code.

Consider this simple Ruby program:

@@@ ruby matz_dsl/beatles_ruby.rb @@@

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

* * * * *

A simple way to learn how to write extensions is to translate Ruby code to C.
It's surprising, but it's a thing you can actually do!

Here's a Ruby program that prints out the Beatles:

@@@ ruby matz_dsl/beatles_ruby.rb @@@

Let's take this apart and convert it to a C extension. In the process, we'll
even get to do some build configuration and automation, write our own `for`
loop, without even needing to allocate our own memory!

We can tackle this extension one line at a time. We need to do two things to
define a module: a memory location to hang it on, and then put a module on that
location.

Here's how we get the memory location for our module:

@@@ ruby matz_dsl/beatles/ext/beatles.c:3 @@@

Here's how to deconstruct that line:

* `VALUE` is syntactic structure (implemented as a `cpp` macro) for storing
  a Ruby object.
* `Beatles` is a name for our object
* `Qnil` is the `nil` object; we're using it as a placeholder, as we need Ruby
  to put an actual module in it when it initializes our extension

Let's take a peek at how that initializer works:

@@@ ruby matz_dsl/beatles/ext/beatles.c:6-9 @@@

By convention, MRI will call this function when it loads our extension. It is
expected to create all of the Ruby objects needed to interact with the C code
in our extension. In this case, that's a single module with a single module
method on it. In an extension like Nokogiri, you'll find dozens of classes and
modules created that link hundreds of C functions to Ruby methods.

For now, let's look right at the first line of our `Init` function. It calls
a function from Ruby's extension API, `rb_define_module` and assigns the
returned Ruby object, a `Module` to the name we pre-defined earlier. So now,
`Beatles` references a Ruby `Module` object. It's basically like this
pseudo-code:

``` ruby
Beatles = Module.new
```

Except, it's a lot more verbose. Hold on to your britches, because things are
about to get a lot more verbose.

You probably noticed another definition for `print_beatles` earlier, and
something about defining it in the initializer. This is basically the same
manuever as before: we need a memory location and a name to hang our function
and method (i.e. `VALUE print_beatles(VALUE self)`) and then we put a Ruby
object into it via the mouthful `rb_define_singleton_method`. The latter takes
the `Beatles` module we defined, and attaches the `print_beatles` function
we're about to define to the `print` method; the last argument, 0, indicates
that the function we're calling takes zero arguments.

Now let's dig into the meat of our extension, `print_beatles`. We'll take it
line by line:

```c
VALUE print_beatles(VALUE self) {
```

To our Ruby programmer eyes, this means that our function takes a Ruby object,
the self reference, and returns a Ruby object.

```c
VALUE beatles, name, puts, kernel, args;
int i;
```

It's often easier to read C functions when the variables are declared before
they are initialized or used. Further, this specifies how our Ruby object
pointers (any `VALUE` is a Ruby object) and our loop counter `i` are allocated:
the pointers and counter are placed on the stack for this function invocation.
However, the actual memory for our Ruby objects will be on the heap managed by
Ruby and its garbage collector.

```c
beatles = rb_ary_new3(4, rb_str_new2("John"), rb_str_new2("Paul"),
                         rb_str_new2("George"), rb_str_new2("Ringo"));
```

Now we're into the meat of our function. Here we're allocating a new Ruby
array which in turn contains four Ruby strings. This is exactly like the array
defined in our Ruby program, except its more verbose when we're writing C. Note
that we didn't need to worry about memory; again, the heap memory for these are
managed by Ruby.

The last thing we create are references to Ruby's `Kernel` module and its `puts` method:

```c
kernel  = rb_define_module("Kernel");
puts    = rb_intern("puts");
```

Only five lines of code into our C function, we can get down to the business of
looping through our array and printing out names:

```c
for (i = 0; i < RARRAY_LENINT(beatles); i++) {
  args = rb_ary_to_ary(rb_ary_entry(beatles, i));
  rb_apply(kernel, puts, args);
}
```

Gird your loins, that's a regular 'ole C loop. It's kinda not fun, next to
writing a Ruby loop with `Enumerable`, is it? On the other hand, this code _is_
very easy for the C compiler to transform into relatively fast machine code.
It's a trade-off!

The first Ruby-centric thing to notice about the loop is that it's using
a macro `RARRAY_LENINT` as the loop condition. This macro, a part of the Ruby
API for extension writers, expands to a bunch of code that gives us the length
of a Ruby array using a primitive integer. Handy!

Inside our loop, we extract an entry from our array of Beatles with
`rb_ary_entry`. This is basically the same as `Array#at`. It gives us a Ruby
object, in this case an `RString`, that we then wrap in array. We have to wrap
it in array because that's how the next function, `rb_apply`, expects it.
`rb_apply` is basically like calling `send` on an object; in this case, we're
basically saying `Kernel.send(:puts, args)`.

Finally our function returns `Qnil`; this is exactly the same as `nil` in
a Ruby program. Literally! They are exactly the same object!

... Along the way, you can see how Ruby is really Matz's DSL for writing C.
A lot of Ruby constructs, like defining modules and methods, translate
directly to a C function.

