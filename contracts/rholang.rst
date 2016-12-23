.. _rholang:

################################################################################
Rholang - A Concurrent Smart Contracting Language
################################################################################

Rholang is a fully featured, general purpose, Turing complete programming language
built from the rho-calculus. It is a behaviorally typed, reflective, higher-order
process language, and the official smart contracting language of RChain - its purpose
is to concretize language-level concurrency.

Necessarily, the language is concurrency-oriented, with a focus on message-passing
through input-guarded channels. Channels are statically typed and can be used as
single message-pipes, streams, or data stores. Similar to typed functional languages,
Rholang will support immutable data structures.

To get a taste of Rholang, here’s a contract named :code:`{Cell}` that holds a value
and allows clients to get and set it:

.. code-block:: scala

   contract Cell( get, set, state ) = {
     select {
       case rtn <- get; v <- state => {
         rtn!( *v ) | state!( *v ) | Cell( get, set, state )
       }
       case newValue <- set; v <- state => {
         state!( newValue ) | Cell( get, set, state )
       }
     }
   }

This contract takes a channel for {get} requests, a channel for {set} requests, and a
{state} channel where we will hold a the data resource. It waits on the {get} and {set}
channels for client requests. Client requests are pattern matched via {case} class.

Upon receiving a request, the contract joins {;} an incoming client with a request against
the {state} channel. This join does two things. Firstly, it removes the internal {state}
from access while this, in turn, serializes {get} and {set} actions, so that they are
always operating against a single consistent copy of the resource - simultaneously providing
a data resource synchronization mechanism and a memory of accesses and updates against the {state}.

In the {case} of {get}, a request comes in with a {rtn} channel where the value, {v}, in i
{state} will be sent. Since {v} has been taken from the {state} channel, it is put back, and
the {Cell} behavior is recursively invoked.

In the {case} of {set}, a request comes in with a {newValue}, which is published to the
{state} channel (the old value having been stolen by the join). Meanwhile, the {Cell} behavior
is recursively invoked.

Confirmed by {select}, only one of the threads in {Cell} can respond to the client request.
It’s a race, and the losing thread, be it getter or setter, is killed. This way, when the
recursive invocation of {Cell} is called, the losing thread is not hanging around, yet the new
{Cell} process is still able to respond to either type of client request.

For an historical narrative leading up to Rholang, see `Mobile Process Calculi for Programming the Blockchain`_.


.. _Mobile Process Calculi for Programming the Blockchain: https://docs.google.com/document/d/1lAbB_ssUvUkJ1D6_16WEp4FzsH0poEqZYCi-FBKanuY/edit

=================
Behavioural Types
=================

The task of creating a tractable and fault-tolerant execution environment for a
system of communicating processes is non-trivial without a built-in mechanism to
standardize the notion of 'safe' interaction among those processes.

Our intention from the beginning was to create a rho-bust language capable of
expressing smart contracts with confidence. Our approach is correct-by-construction,
'programs from theorems' language development. But to have true utility, Rholang
had to be expressive and easy to reason about, which means that it had to boast
a full-bodied typing discipline and include an automated formal spec. verification
feature for mission-critical contracts. When we commit to the mobile process calculi,
we are afforded those mechanisms in the form of 'Behavioral Types'.

Behavioral types represent a novel typing discipline that constrains not only the
shape of input and output, but the permitted order of inputs and outputs among
communicating and (possibly) concurrent processes. They exist to specify 'safe'
interaction between objects in a composite system; we can think of an object
(i.e. a process, channel, or variable), with an assigned behavioral type, as
an object that is necessarily bound to operate in an authorized set of predictable
and discrete interaction patterns.

.. note::

  TODO: Example

Thereby, we can compose sub-processes while preserving their individual typings,
which means that, whether the number of processes that execute (concurrently or not),
between the time a transaction is initiated and the time it is verified, is one process,
or 1,000,000 processes, correctness of data is always preserved. And that whether
data is sent across the network to 1 location, or to 1,000,000 locations, correctness
is preserved.

There are a number of additional benefits that we get for free with behavioral types:

System informatics analysis and optimization criterion for:

* Data/Information Flow
* Control  Flow
* Resource Access Patterns
* Capability based addressing

In their seminal paper, `Logic as a Distributive Law`_, Mike Stay & Gregory Meredith,
develop an algorithm to iteratively generate a spatial-behavioral logic from any monadic
data structure. The result is equivalent to a full-bodied type system decorated with
modal logical operators, which can, not exclusively, be leveraged to generate a
mathematically precise specification for polymorphic structure and behavior of processes.

The behavioral type systems Rholang will support make it possible to evaluate collections
of contracts against how their code is shaped and how it behaves. As such, Rholang contracts
elevate semantics to a type-level vantage point, where we are able to scope how entire
protocols can safely interface.

For more information, see `Rholang Specification - Contracts, Composition, and Scaling`_.

.. _Logic as a Distributive Law: https://arxiv.org/pdf/1610.02247v3.pdf
.. _Rholang Specification - Contracts, Composition, and Scaling: https://docs.google.com/document/d/1gnBCGe6KLjYnahktmPSm_-8V4jX53Zk10J-KFQl7mf8/edit#heading=h.k4bk2akncduu
