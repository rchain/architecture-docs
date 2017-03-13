.. _contract-design:

******************************************************************
Contract Design
******************************************************************

In this section on contract design, we investigate the formal model of computation that RChain uses to achieve concurrency on a variety of architectural layers. We demonstrate how that model extends to accomodate best-in-industry language attributes such as meta-programming, parallelization, asynchronicity, code mobility, reactive API's, and compile-time security-type checks.

Rho-calculus: A Concurrent Model of Computation for the Blockchain
===================================================================

Despite the growing body of knowledge in support of concurrency, there are relatively few programming languages that address concurrent processing in their core model. Generally speaking, *concurrency is a structural property that allows processes to execute with maximum order-independence*. RChain, and any other BC-based platform, admits the inevitable and significant computational overhead of a consensus mechanism. With the consensus overhead in mind, RChain chose the **rho-calculus** model of concurrent computation.

The rho-calculus is one constitutent of a mucher larger class of formal systems known as the **process calculi**. It was introduced as a variant of the **π-calculus** in 2004 by Greg Meredith. Like the π-calculus, the rho-calculus is an formal abstraction based on the interaction of processes, but the rho-calculus is distinguished from the π-calculus in that it supports "reflection". “Rho-calculus” stands for reflective, higher-order calculus.

For more information, see `The Polyadic Pi-Calculus`_ and `Higher Category Models of the Pi-Calculus`_.

.. _The Polyadic Pi-Calculus: http://www.lfcs.inf.ed.ac.uk/reports/91/ECS-LFCS-91-180/
.. _Higher Category Models of the Pi-Calculus: https://arxiv.org/abs/1504.04311

Reflection is widely recognized as a key feature of practical programming languages. Known broadly as "meta-programming", reflection is a disciplined way to turn programs into data that programs can operate on and then turn the modified data back into new programs. Java, C#, and Scala eventually adopted reflection as a core feature, and even OCaml and Haskell have ultimately developed reflective versions [#]_. The reason is simple: at industrial scale, programmers use programs to write programs. Without that computational leverage, it would take too long to write advanced industrial scale programs.

Preamble: Basic Rho-calculus Constructs
--------------------------------------------------------------------------

The rho-calculus constructs *processes* and *channels* where processes may only interact by passing messages over channels.

A process can be thought of as **an abstraction of an independent thread of control.** 

A process:

1. Has an associated name (identifier).
2. Is of arbitrary complexity; a process could be a sub-routine, a smart contract, an application etc.
3. May be serialized/deserialized to/from storage.

A process can be stateful but does not assume persistent state and can therefore be thought of as the more general form of a “smart contract”, which is necessarily stateful[#]_. Hence, every smart contract is a process, but not every process is a smart contract.

A channel can be thought of as **an abstraction of a communication link between two processes.**

A channel:

1. Has an associated name.
2. Is of arbitrary complexity; and
3. Is provably unguessable and anonymous unless given.

The notion of a channel is key to the RChain platform. It is sufficiently abstract to cover a wide range of functionality such that a channel may be a local variable, a global variable, a location in shared memory, a location in a data store, a network location (TCP/IP socket), etc.

Channels vary greatly in their implementations, but consistently represent access to a location. If a process has the name of a channel, it may communicate with the objects at the other end of that channel. If the name of a channel is unknown to a process, then it is indifferent to all of the computation and communication occuring over that channel and, otherwise, proceeds in parallel.

In terms of implementation, a named channel is nothing more than a variable name that is shared between a read-only and write-only process, and the rho-calculus model *only* allows computation when those processes meet at a channel. But channels (and processes) can be passed between processes as well, so they become an exceptionally useful tool to dynamically manage the internal structure of processes at runtime.

Processes interact by sending and receiving messages over channels, where **a message may be any supported data type, ranging from a literal, to a data structure, to the code of a process.**

.. [#] The coming sections will describe smart contracts as processes with persistent state, consistent with an interpretation of values as linear resources.

Formal Syntax and Semantics
---------------------------------------------------

The rho-calculus presents the following syntax, where :code:`P` and :code:`Q` are processes. These basic terms comprise the primitives for RChain's contracting language:


::

  P,Q ::=   0                  // nil or stopped process

            |   x!( @Q )       // output ("bang")
            |   for( ptrn <- x).P // input-guarded process
            |   *x             // evaluate
            |   P|Q            // parallel composition

  x,ptrn ::= @P                // quoted process


Each of the above terms are processes. The first three terms denote I/O, describing the actions of message passing:

* :code:`0` is the stop/halt process that is the ground of the model.

* The output process, :code:`x!( @Q )`, sends :code:`@Q` on the channel, :code:`x`. In more concrete terms, this operator binds the value :code:`@Q` to the variable, :code:`x`.

This representation depicts the quoted process, :code:`@Q`, being bound to :code:`x`, but any supported data type, simple or complex, is subject to binding, including a serialized process.

* The input process, :code:`for( ptrn <- x ; if cond. ).P`, searches for values satisfying a defined pattern, :code:`ptrn`, on the        channel :code:`x`. On matching that pattern, the continuation, :code:`P`, is invoked with that value as an argument[#]_. This is a unique implementation of an input term that is improved from other message-passing based languages in three respects:

    1. A channel is a statically typed, monadically structured, and provably persistent queue subject to structural pattern matching.

    2. The input term applies an (optional) if-conditional to examine the result of the pattern match for properties *which may not be          structural.*
    
    3. Because channels may be bound to a number of data sources, the output and input terms may be implemented as the producer and              consumer of a "live" data feed analogous to those leverged in reactive paradigms. 

These, and additional safety mechanisms, are further demonstrated in the next section on use-cases.

The next term is structural, describing concurrency:

* :code:`P|Q` is the form of a process that is the *parallel composition* of two processes, :code:`P` and :code:`Q`.

Two additional terms are introduced to provide reflection:

* :code:`@`, the “Reflect" operation serializes or "quotes" the code of a process. This allows processes to send other processes as messages.

* :code:`*`, the “Reify” operation deserializes or "unquotes" and evaluates the code of a process.

In total, there are six very simple, yet enormously powerful language primitives which provide built-in support for functions that are otherwise absent in the blockchain space:

* Maximum concurrency/parallelism
* Structural pattern matching and conditional evaluation
* Unbounded, persistent, and monadically structured queues
* Reactive evaluation on live data feeds; and
* Serialization/deserialization primitives for code mobility

Evaluation Model - Reduction
-------------------------------------------------------

Finally, the rho-calculus gives a single evaluation rule to realize computation, known as the “COMM” rule. It is the only rule which directly reduces a rho-calculus term:


::


  for( ptrn <- x ).P | x!( @Q ) -> P { @Q := ptrn } //COMM rule



It says that if :code:`for( ptrn <- x ).P` and :code:`x!(@Q)` are executing in parallel composition, and the value :code:`@Q` being sent on the channel :code:`x` matches a pattern, :code:`ptrn`, being searched for on :code:`x`, then the I/O pair reduces and the continuation :code:`P` executes in an environment where :code:`Q@` is bound to :code:`ptrn`. That is, where :code:`ptrn` is substituted for :code:`@Q` in the body of :code:`P`.

The COMM rule is *atomic*. If a value satisfying :code:`ptrn` is ever committed to :code:`x` *and* witnessed at :code:`x`, then computation must occur, but if either I/O process is absent, if :code:`ptrn` is not matched, or if the optional :code:`if-cond.` is not satisfied, then the I/O pair blocks and the system freezes. This is the only rule in the rho-calculus model that allows computation to continue ( hence “continuation” ), yet it’s fundamentally different from beta reduction given by the lambda calculus in that computation is a result of the *coordination* of two processes, rather than the sequential evaluation of one.

Use-Cases: Contract Interaction
------------------------------------------------------------

This case contructs a system of four processes operating in parallel: a decentralized application server process, :code:`L`, and three clients, :code:`P`, :code:`Q`, and :code:`R`, submitting work requests to :code:`L`:

[ Diagram ]

This interaction assumes that :code:`P`, :code:`Q` and :code:`R` have been previously given the name of a channel, :code:`bookMe`, which is the location where :code:`L` listens for input. In parallel, :code:`P`, :code:`Q`, and :code:`R` each commit a work requests and a return channel, :code:`(WrkReqP, addr)`, :code:`(WrkReqQ, foo)`, and :code:`(WrkReqR, bar)`, respectively, to :code:`bookMe`. The order-arrival of the work requests is non-deterministic, yet request processing efficacy remains unhindered because the model makes no commitment to sequencialization. 

The application process filters through the :code:`bookMe` channel for input that matches that matches a generic pattern, :code:`(WrkReq, rtn)`, which consists of (i) a work request, :code:`WrkReq`, which is some typed collection of fields consisting of meta-data and a process to be evaluated, and (ii) a typed return channel, :code:`rtn`, where it can return the result. 

Out of :code:`P,Q` and :code:`R`, only the input from :code:`P`, :code:`(WrkReqP, addr)`, satisfies the full pattern definition. Although the work requests of :code:`Q` and :code:`R` may satisfy the pattern for :code:`WrkReq`, their return addresses, :code:`foo` and :code:`bar`, are invalid.

After the application process witnesses the input :code:`(WrkReqP, addr)`, satisfying :code:`(WrkReq, rtn)`, at :code:`bookMe`, a reduction must occur. The I/O processes cancel and the continuation, :code:`rtn!(*WrkReq)`, executes with :code:`(WrkReqP, addr)` as arguments:

[ Diagram ]

After reduction, both I/O processes have halted. The application evaluates the work request and returns the results, :code:`addr!(*WrkReqP)`. Note that :code:`L` does not recurse, so, for all intents and purposes, no more work requests can be processed. The two clients, :code:`Q` and :code:`R` committed work requests which did not observe the input pattern defined by :code:`L`, so the two output operations block indefinitely and no computation occurs on those input.

There are two key insights here:

1. This interaction pattern between P and L is indiscriminant of channel implementation.
2. The reduction between :code:`P` and :code:`L` faithfully encodes an atomic transaction.

In reality, this very naive example would consist of many lower-level reductions/transactions/computations that are not depicted. For example, not only does :code:`P` execute in parallel with an arbitrary number of other clients, but the work request, :code:`WrkReqP`, of :code:`P` itself contains a process that must be evaluated via the same reduction rule. Furthermore, this example depicts :code:`L` returning the evaluation results of the work request, but it constructs no process for :code:`P` to receive the results. If such existed, it would witness another reduction/transaction on return.

Formally unifies an atomic unit of computation with an atomic transaction, such that all computation on the platform is provably provably tied to an economic mechanism, making the RChain a provably concurrent and parallel, reflective, indefinitely scalable, micro-transaction supporting, blockchain-powered, smart contracts platform

Notice that the model side-steps sequentialization by committing to process-independence. It does so by defining a generic(formal) continuation, :code:`{ rtn!(*WrkReq) }`, that is parametric on the input of each independent client. This is analogous to a formal method definition that is automatically invoked when actual parameters are passed to it by another process, save this model allows each process to execute in parallel composition.

This model assumes:

ii. Server process does not recurse.
iii. Output operation is no computationally significant without the input operation.
iv. Their is no input process waiting on :code:`rtn` for the results of :code:`*WrkReqP`

:code:`WrkReq` itself defines a process, which means that it is possibly a smart contract and possibly stateful. For example, the request could include the value of an account balance that is decremented per evaluation step, or per booking fee, within the body of :code:`*WrkReq`. It could include a history of travel destinations with user preferences of that history. If :code:`Server` is processing requests for a DApp which generates an optimal travel destination given the users history of travel and cultural attributes of global locations, then persistence of travel history, and account balance, are obligatory.

Contracts are persisted "from off of the stack", or post-execution.

Note, this model assumes that at least the sender possesses the address of :code:`Contract2`. Note also, after it sends :code:`v`, :code:`Contract1`, has been run to termination. Thus, it is incapable of sending anything else unless prompted. Similarly, after it invokes its continuation, :code:`Contract2` has been run to termination, and it is incapable of receiving further messages.

.. figure:: ../img/82846984.png
   :align: center
   :width: 926
   :height: 124
   :scale: 80

Executing in parallel with a number of other processes, an external actor prompts :code:`Contract1` to send a value, :code:`v`, on the channel :code:`address` i.e. the address of :code:`Contract2`. If :code:`Contract1` has no value to send, it blocks. If :code:`Contract2` has not received a value, it blocks and the continuation is not triggered.

For an example of how this model is adaptable to industry trends in reactive programming, observe the following two contracts, which interact over live data feeds:


.. figure:: ../img/21300107.png
   :width: 1014
   :height: 142
   :align: center
   :scale: 80


:code:`Contract1` is prompted to send a set of  values, :code:`vN`, on the channel :code:`address` i.e. the address of :code:`Contract2`. In this scenario, :code:`Contract2` is like a thread. It recieves a set of values from the head of a stream that is dual to a set of values being produced at its tail. When the set of values, :code:`v1...vN`, is witnessed at the channel, :code:`address`, a continuation is invoked with :code:`v1...vN` as an argument. While the interaction between :code:`Contract1` and :code:`Contract2` is asynchronous, the input operation :code:`address?(v1...vN)` and :code:`Continuation(v)` of :code:`Contract2` are necessarily sequential. :code:`address?(v1...vN)` is said to "pre-fix" :code:`Continuation(v)` in every execution instance.

Behavioral Types
----------------------------------------------------

A behavioral type is a property of an object that binds it to a discrete range of action patterns. Behavioral types constrain not only the structure of input and output, but **the permitted order of inputs and outputs among communicating and (possibly) concurrent processes under varying conditions.**

Behavioral types are specific to the mobile process calculi particularly because of the non-determinism the mobile calculi introduce and accommodate. More specifically, a concurrent model may introduce multiple scenarios under which data may be accessed, yet possess no knowledge as to the sequence in which those scenarios occur. Data may be shareable at a certain stage of a protocol but not in a subsequent stage. In that sense, resource competition is problematic; if a system does not respect precise sharing constraints on objects, mutations may result. Therefore we require that network resources are used according to a strict discipline which describes and specifies sets of processes that demonstrate a similar, “safe” behavior.

The Rholang behavioral type system will iteratively decorate terms with modal logical operators, which are propositions about the behavior of those terms. Ultimately properties data information flow, resource access, will be concretized in a type system that can be checked at compile-time.

The behavioral type systems Rholang will support make it possible to evaluate collections of contracts against how their code is shaped and how it behaves. As such, Rholang contracts elevate semantics to a type-level vantage point, where we are able to scope how entire protocols can safely interface.

In their seminal paper, `Logic as a Distributive Law`_, Mike Stay & Gregory Meredith, develop an algorithm to iteratively generate a spatial-behavioral logic from any monadic data structure.

.. _Logic as a Distributive Law: https://arxiv.org/pdf/1610.02247v3.pdf

Significance
=================================================

This model has been peer reviewed multiple times over the last ten years. Prototypes demonstrating its soundness have been available for nearly a decade. The minimal rho-calculus syntax expresses six primitives - far fewer than found in Solidity, Ethereum’s smart contracting language, yet the model is far more expressive than Solidity. In particular, Solidity-based smart contracts do not enjoy internal concurrency, whereas Rholang-based contracts assume it.

To summarize, the rho-calculus formalism is the first computational model to:

1. Realize maximal code mobility *and* concurrency via ‘reflection’, which permits full-form, quoted processes to be passed as first-class-citizens to other network processes.

2. Lend a framework to mathematically verify the behavior of reflective, communicating processes and fundamentally concurrent systems of dynamic network topology.

3. Denote a fully scalable design which naturally accommodates industry trends in structural pattern matching, process continuation, Reactive API’s, parallelism, asynchronicity, and behavioral types.

RhoLang - A Concurrent Blockchain Language
=========================================================

Rholang is a fully featured, general purpose, Turing complete programming
language built from the rho-calculus. It is a behaviorally typed, **r**-eflective,
**h**-igher **o**-rder process language and the official smart contracting language
of RChain. Its purpose is to concretize fine-grained, programmatic concurrency.

Necessarily, the language is concurrency-oriented, with a focus on message-passing through input-guarded channels. Channels are statically typed and can be used as single message-pipes, streams, or data stores. Similar to typed functional languages, Rholang will support immutable data structures.

To get a taste of Rholang, here’s a contract named :code:`Cell` that holds a value and allows clients to get and set it:

.. code-block:: none

   contract Cell( get, set, state ) = {
     select {
       case rtn <- get; v <- state => {
         rtn!( *v ) | state!( *v ) | Cell( get, set, state )
       }

       case newValue <- set; v <- state => {
         state!( *newValue ) | Cell( get, set, state )
       }
     }
   }

This contract takes a channel for :code:`get` requests, a channel for :code:`set` requests, and a :code:`state` channel where we will hold a the data resource. It waits on the :code:`get` and :code:`set` channels for client requests. Client requests are pattern matched via :code:`case` class [#]_.

Upon receiving a request, the contract joins :code:`;` an incoming client with a request against the :code:`state` channel. This join does two things. Firstly, it removes the internal :code:`state` from access while this, in turn, sequentializes :code:`get` and :code:`set` actions, so that they are always operating against a single consistent copy of the resource - simultaneously providing a data resource synchronization mechanism and a memory of accesses and updates against the :code:`state`.

In the case of :code:`get`, a request comes in with a :code:`rtn` address where the value, :code:`v`, in :code:`state` will be sent. Since :code:`v` has been taken from the :code:`state` channel, it is put back, and the :code:`Cell` behavior is recursively invoked.

In the case of :code:`set`, a request comes in with a :code:`newValue`, which is published to the :code:`state` channel (the old value having been stolen by the join). Meanwhile, the :code:`Cell` behavior is recursively invoked.

Confirmed by :code:`select`, only one of the threads in :code:`Cell` can respond to the client request. It’s a race, and the losing thread, be it getter or setter, is killed. This way, when the recursive invocation of :code:`Cell` is called, the losing thread is not hanging around, yet the new :code:`Cell` process is still able to respond to either type of client request.

For a more complete historical narrative leading up to Rholang, see `Mobile Process Calculi for Programming the Blockchain`_.

.. _Mobile Process Calculi for Programming the Blockchain: https://docs.google.com/document/d/1lAbB_ssUvUkJ1D6_16WEp4FzsH0poEqZYCi-FBKanuY

.. [#] Lawford, M., Wassyng, A.: Formal Verification of Nuclear Systems: Past, Present, and Future. Information & Security: An International Journal. 28, 223–235 (2012).
.. [#] In addition to selecting a formally verifiable model of computation,  are investigating a few verification frameworks such as the `K-Framework`_ to achieve this. 
.. _K-Framework: http://www.kframework.org/index.php/Main_Page
.. [#] See Scala Documentation: Reflection
.. [#] See Scala Documentation: Sequence-Comprehensions
.. [#] See Scala Documentation: Delimited Continuations
.. [#] See Scala Documentation: Case Classes
