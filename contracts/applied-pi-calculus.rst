.. _applied-pi-calculus:

################################################################################
The Applied 𝛑-Calculus
################################################################################

There are relatively few programming paradigms and languages that handle concurrent
processes in their core model. Instead, they bolt on some kind of threading-based
concurrency model to address being able to scale by doing more than one thing at a time.
Mobile process calculi are the former. They provide one set of models, which we’ve chosen,
that address concurrent processes in their core model. They provide a fundamentally
different notion of what computing is. In these models, computing arises primarily
from the interaction of processes.

The family of mobile process calculi provides an optimal foundation for a system of
interacting processes. Among these models of computation, the π-calculus stands out.
It models processes that send queries over channels. This approach maps very well onto
today's Internet and has been used as the tool of choice for reasoning about a wide
variety of concerns that are essential for distributed protocols.

==================
Syntax
==================

The π-calculus denotes names and processes where a name is either a channel of communication
or a variable, and a process is a protocol of arbitrary size. The calculus gives a formal
system to describe concurrent, communicating processes - a tool by which we can reason
about concurrent systems before their implementation.

Given some notion of channel, the calculus builds a handful of basic forms of process, where
P and Q are processes::

  P,Q :: = 0
           | for (ptrn <- x). P
           | x!(m)
           | P|Q
           | (new x). P
           | (def X(ptrn) = P)[m]
           | X(m)

The first three terms are about I/O, describing the actions of message passing:

* :code:`0` is the form of the inert or stopped process that is the ground of the model

* :code:`for ( ptrn <- x ). P` is the form of an input-guarded process, :code:`P`, waiting
  for a message on channel :code:`x` that matches a pattern, ptrn. On receiving such a
  message, :code:`P` will execute in an environment where any variables in the pattern are
  bound to the values in the message

* :code:`x!( m )` is the form of sending a message, :code:`m`, on a channel, :code:`x`

The second three terms are about the concurrent nature of processes, the creation of channels,
and recursion:

* :code:`(new x)P` is the form of a process that executes a subprocess, :code:`P`, in a context
  in which :code:`x` is bound to a fresh channel, distinct from all other channels in use

* :code:`(def X( ptrn ) = P)[ m ]` and :code:`X( m )`, these are the process forms for recursive
  definition and invocation

Note that *for* - comprehension is syntactic sugar for treating access to a channel monadically,
by use of the *continuation* monad. The result is that channels are pattern-input guarded. The
for-comprehension-based input can now be smoothly extended to input from multiple sources, each/all
of which must pass a pattern filter, before the continuation is invoked. This extension as known
as the *Applied  π-calculus.*

Using a for-comprehension allows the input guarded semantics to be parametric in the monad used for
channels, and hence the particular join semantics can be supplied polymorphically.

The for-comprehension also provides the proper setting in which to interpret Kiselyov’s LogicT monad
transformer - searching down each input source until a tuple of inputs that satisfies the conditions
is found. A means to programmatically describe interleaving policy is critical for reliable and
performant services. This is the actual importance of LogicT. **Finally, now we have a syntactic
form for nested transactions. Specifically, a process can only run in a context in which all of
the state changes associated with the input sources and conditions are met**. Thus a programmer, or
a program analyzer, can detect transaction boundaries syntactically. This is vital for contracts
involving financial and other mission-critical transactions.

Getting concurrency right is hard, and support from this kind of typing discipline will be extremely
valuable to ensure end-to-end correctness of a large system of communicating processes.

For more information, see The `Polyadic Pi-Calculus - A Tutorial`_ and `Higher Category Models of the Pi-Calculus`_.

.. _Polyadic Pi-Calculus - A Tutorial: http://www.lfcs.inf.ed.ac.uk/reports/91/ECS-LFCS-91-180/
.. _Higher Category Models of the Pi-Calculus: https://arxiv.org/abs/1504.04311
