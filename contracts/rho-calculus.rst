.. _rho-calculus:

################################################################################
The Rho-Calculus
################################################################################

Even a model based on the applied π-calculus and equipped with a behavioral typing
discipline is still not quite the best fit for a programming language for the
decentralized Internet, let alone a contracting language for the blockchain.
There’s another key ingredient: The rho-calculus.

Rho-calculus, a variant of the π-calculus, was introduced in 2004 and provided the
first model of concurrent computation with reflection. 'Rho' stands for reflective,
higher-order. Reflection is now widely recognized as a key feature of practical
programming languages.

==================
Syntax
==================

Reflection is a disciplined way to turn programs into data that programs can operate
on and then turn the modified data back into new programs.

To formalize this feature, the rho-calculus denotes names and processes where a name
**may be a channel of communication, a variable, or a 'quoted' process of arbitrary
size**::

  P,Q :: = 0
           | for (ptrn <- x). P
           | x ⦉ P ⦊
           | ⌝ x ⌜
           | P|Q
           | (new x). P
           | (def X(ptrn) = P)[m]
           | X(m)

  x, ptrn :: =  ⌜P⌝

It provides two additional terms to enable reflection:

* :code:`⌜P⌝`, the 'Reflect' term, introduces the notion of a 'quoted process', which is a
  process that has been packaged up as a name, :code:`x`, or pattern :code:`ptrn`

* :code:`⌝ x ⌜`, the 'Reify' term, allows a quoted process to transform back into its
  original format

* The, :code:`x ⦉ P ⦊`, operator packages quoted processes and makes them available on
  channel, :code:`x`. It may interpreted as :code:`x!( ⌜P⌝ )`.

By this syntax, we may reason about concurrent systems where processes are passed around as
first-class citizens. This syntax also gives the basic term language which will comprise
the Rholang type system primitives. Note that channels have sophisticated internal structure
and may, not exclusively, be used as data stores.

This model has been peer reviewed multiple times over the last ten years. Prototypes
demonstrating its soundness have been available for nearly a decade. This extended syntax
increases the set of contract building primitives to a grand total of nine primitives,
far fewer than found in Solidity, Ethereum’s smart contracting language, yet the model is
far more expressive than Solidity. In particular, Solidity-based smart contracts do not
enjoy internal concurrency.

Java, C#, and Scala eventually adopted reflection as a core feature, and even OCaml and Haskell
have ultimately developed reflective versions. The reason is simple: at industrial scale,
programmers use programs to write programs. Without the computational leverage, it would
take too long to write advanced industrial scale programs. Lisp programmers have known for
decades how powerful this feature is. It simply took modern languages some time to catch up
to that understanding.

The rho-calculus is the first computational model to combine all of these core requirements:
behaviorally typed, fundamentally concurrent, message-passing model, with reflection. For
details, see `A Reflective Higher-Order Calculus`_ and `Namespace Logic - A Logic for a Reflective Higher-Order Calculus`_.

.. _A Reflective Higher-Order Calculus: http://www.sciencedirect.com/science/article/pii/S1571066105051893
.. _Namespace Logic - A Logic for a Reflective Higher-Order Calculus: http://citeseerx.ist.psu.edu/viewdoc/summary?doi=10.1.1.95.9601
