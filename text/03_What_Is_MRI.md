# What is MRI?

I've shown you how you can explode Ruby code into C code with a few mechanical
steps. That was weird, right? Why would I drag you through that?

Well, here's a point I want to make: Ruby is a thing that Matz made for himself
and his way of programmming, and that shows through in many ways. And
yet, people use it for _their_ way of programming. But then they get a little
surprised when Matz's way of programming isn't quite like their way of
programming.

Let me try to break down those misunderstandings:

## 1. Ruby is a scripting language

Of the following languages, Ruby is closet to which?

* Smalltalk
* Java
* Python 2

If you answered Python 2, you are correct. Up until recently, I would excuse
you for saying that Ruby is closer to Perl 5 or BASIC than anything else.
Bytecode execution is a new trick for Ruby; for years it got by by creating
a syntax tree and then interpreting each AST node.

Perl is an important influence on Ruby. It helps to remember it when you see
weird dollar global variables or enjoy the fact that regular expressions have
a literal representation in the language. Dig deeper, and you'll find Perl is
crucial to understanding MRI, the software.

MRI is all about scripting, mostly in the UNIX environment. Thus it favors
processes over threads, text over binary data, and getting stuff done over
getting stuff fast.

Lua scripts games; Perl scripts text. What does Ruby script? Mostly,
C libraries and text. As I've noted previously, Ruby is a way for Matz to write
the kind of C he wants to write; sometimes without even writing C in the first
place.

I think, long term, our best hopes are two-fold. First, that Rubinius and JRuby
get to the point where their performance is competitive with HotSpot and V8, to
the point where they are only a year or two behind. The second, that MRI
reaches the level of sophistication of LuaJit. The goals of the two
implementations aren't too dissimilar, so it not out of the ballpark to hope
that their structural qualities begin to converge as well.

## 2. Ruby's core team has (mostly) different ambitions for the language than startups and Rails users do

When you hold MRI up to the likes of Hotspot, V8, or even older/less ambitious
virutal machines like LuaJit or Strongtalk, it doesn't hold up well. Those
teams were seeking the very best of performance. They did a lot of research,
got the smartest VM guys around in one room, and they produced some pretty
great software.

MRI is not about that. MRI is about developer happiness. When they favor a GVL
and process concurrency over fine-grained locks and threads, they're doing this
to optimize for the ease of writing scripts or banging web applications
together quickly. It's not that they don't _want_ you to write Twitter in Ruby,
it's that relatively few Ruby users are writing Twitter.

Of note was Matz's keynote at RubyConf 2012. Whenever he was asked about
parallelism, immutable data structures, threading, etc. he said, basically,
"that's not the kind of language I want Ruby to be". Matz is open to feedback
and help to make that an optional part of Ruby, but the tea leaves say he's
hesistant to go whole-hog in that direction.

On the other hand, consider the effort to standardize Ruby. To put a big,
heavy-weight document, a bowtie per se, on Ruby and call it an Official Thing.
Probably most of us here scoff at the notion. Standards, who needs them?

I'm told that in Japan, the technology culture is very much about blessed,
standardized things. Getting that checkmark for Ruby woudl be a big deal for many on
the core Ruby team. And so that is a thing that gets worked on, while us
Western whippersnappers scratch our heads or point sticks at Ruby's maintainers
via Twitter.

## 3. Ruby does not use Linux or semantic versioning conventions

Ruby doesn't use an odd-numbers unstable, even numbers stable release scheme
(though it seemed to in the past?). Ruby doesn't use semantic versioning,
because that wasn't invented when Ruby was invented, even though it has all the
right number of dots in the versions to use semantic versioning.

Ruby's versions are basically "Major release dot minor release P patch
level".  Except the major release is multiplied by 0.1. So Ruby 2.0.0p195 is
Ruby version twenty, patchlevel 195. Things can't break in Ruby 2.0.1, but they
could break in Ruby 2.1.

That's the way it works. It probably rubs you the wrong way. It's much more
sane to go put a version number on your own thing, your way, than to grouse
about how Ruby uses version numbers. Sorry.

## But, MRI isn't Ruby

There are social differences between what Western Ruby users want out of Ruby
and what Eastern Ruby users want out of Ruby. One area where we, in the west,
need to help out is conceiving of MRI *as* Ruby. Ruby, the language, can have
modern runtimes, excellent GC, awesome libraries, and stable version numbering.
Projects like JRuby and Rubinius are the way forward in this regard. And they
are Ruby. Not just MRI. MRI is Matz's Ruby Interpreter, always will be. But
Ruby, Ruby _can_ have lots of owners and be a multitude of implementations and
trade-off choices.

