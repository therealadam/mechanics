The Mechanics of Ruby
=====================

Once upon a time, there was a guy who went by Matz. Every day, Matz would write
C code, but in his own idiomatic way that borrowed from Perl, Smalltalk, and
Lisp. But then, one day, he decided to write his own interpreter for his own
language; it would be a language that codified how he wrote C, but at a much
higher level. And every day after that, more and more people used Matz's
interpreter to write their own code. And soon after that, people started using
another guy's language for building web applications. And soon after that,
a lot of people were using Ruby. Finally, one day, people figured out how to
make educated trade-offs about time, performance, and happiness when writing
Ruby. And from that day on, everyone was happy when they were writing Ruby and
only a little sad when they had to reach for another tool to solve a different
kind of problem.

* * * * *

If you read my Twitter timeline (Hello, NSA!), you suffer several fools and
a couple well-meaning but sharp-tongued smart people who like to poke fun at
Ruby's shortcomings. MRI isn't concurrent and its GC is slow, Rails is big and
slow, the Ruby community at large sometimes makes regretable design decisions.
To some extent, these are all true and are all over characterizations. But
wouldn't it be something if there was a world where none of them were true?

Wouldn't it be cool if we were scientists. Like, movie scientists. And not just
like Egon Spangler from Ghostbusters. What if we were Val Kilmer from Real
Genius. Prankster scienstists; wicked smart, using our knowledge of how
everything works to make awesome jokes.

We could be that way for our beloved Ruby. We could understand the shortcomings
and trade-offs in its implementation. We would know why Rails is as big as it
is and when to cut against the grain. We, as a community, would know more about
how to poke the insides of our programs and understand how they operate.

Let's dive into that.

