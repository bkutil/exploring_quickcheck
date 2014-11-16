# About

Exploring [QuickCheck](https://github.com/peter-murach/finite_machine)
by trying to implement a few QuickCheck examples using [Rantly](https://github.com/hayeah/rantly).

Some of the examples come from [An introduction to QuickCheck with number
theory and red black trees](http://matt.might.net/articles/quick-quickcheck/).

The red-black tree test is using the [avl_tree](https://github.com/nahi/avl_tree) gem,
and 'state machine based' testing builds on [finite_machine](https://github.com/peter-murach/finite_machine).

Note: Transition list for the state machine could be in theory generated using Rantly, which would
automatically make it shrinkable. At the moment, its just random number - a probability weight used
to determine which transition to perform. Also, one could do without a state machine, just calling
the ops on the tree directly - otoh, state machine could provide a framework for multithreaded testing for free.

# Usage

    $ bundle
    $ bundle exec rake test

# See also

## Property based testing

  * [Jessica Kerr - Property based tests for better code](https://www.youtube.com/watch?v=shngiiBfD80).
    Prop testing pros & cons,
    composing generators, using ports&adapters to incorporate failure as a
    response from (remote) services, defining 'business
    value/success/correctness' in terms of properties.
  * [Property based testing, what is it](http://blog.jessitron.com/2013/04/property-based-testing-what-is-it.html)
  * [Testing with generative testing: an example in Ruby](http://blog.jessitron.com/2014/09/tdd-with-generative-testing-example-in.html)
  * [Property based testing of higher order functions](http://blog.jessitron.com/2014/02/property-based-testing-of-higher-order.html)

## QuickCheck

  * [Introduction to QuickCheck](http://www.youtube.com/watch?v=zi0rHwfiX1Q), talk by John Hughes, co-author of QuickCheck.
  * Another talk on [QuickCheck CI](http://www.youtube.com/watch?v=gPFSZ8oKjco) - Cherry-pick example-based failing tests from
    property based test runs.
  * [QuickCheck Package page](http://hackage.haskell.org/package/QuickCheck)
  * [Original QuickCheck Sources](http://www.cse.chalmers.se/~rjmh/QuickCheck/QuickCheck.hs)
  * [QuickCheck used to catch bugs in LevelDB](https://raw.github.com/strangeloop/lambdajam2013/master/slides/Norton-QuickCheck.html)
  * Corresponding [Erlang properties/state machine](https://github.com/norton/lets/blob/master/test/qc/qc_leveldb.erl)
  * [QuickCheck download from Quviq](http://www.quviq.com/downloads/)


# Implementations

For Ruby, there are different implementations:

  * [Rantly](https://github.com/hayeah/rantly)
  * [RushCheck](https://github.com/IKEGAMIDaisuke/rushcheck), closer to original QuickCheck than Rantly.
  * [RubyCheck](https://github.com/mcandre/rubycheck)

For other languages [Nat Pryce](https://github.com/npryce) has compiled a list of [quickcheck-like ports](https://gist.github.com/npryce/4147916).

# Tools

Gem for random-data-generators [generatron](https://github.com/jessitron/generatron)
- [Generator module](https://github.com/jessitron/generatron/blob/master/lib/generatron/generators.rb)
is interesting. Builds on Rantly.
