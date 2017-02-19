.. _rhovm:

******************************************************************
Execution Model
******************************************************************

Introduction
==================================================================

To begin, a client writes a program (contract) in Rholang. The contract is compiled into bytecode and fed to the **Rho Virtual Machine** (RhoVM). 

It's useful to reiterate that each virtual machine corresponds to a finite state transition table. Given a machine state configuration, and a legal transitions, the machine runs to it's next state, where it (maybe) awaits further instructions. In the case of the RhoVM, state configuration and transitions are expressed in bytecode. The VM applies the bytecode it's been fed to update it's state configuration. 

State transitions in RhoVM are realized by the rho-calculus I/O reduction semantics, which consist of a basic substitution rule:


::


    for ( y <- x )P | x! ( @Q ) -> P { @Q -> y }


The instruction reads: for the output operation :code:`x!` commiting the code of the process :code:`@Q` to the location :code:`x`, running in parallel with the input operation :code:`for ( y <- x )P` waiting for a pattern :code:`y` to appear at the location :code:`x`, execute the continuation :code:`P` in an environment where :code:`@Q` is bound (maps) to :code:`y`.

At the lowest level each instance of the VM maintains a set of environments into which bindings of locations to values will be committed. **Variable bindings are updated via bytecode instructions that are, essentially, the repeated application of rho-calculus reduction rule**.The two main dynamic bindings at runtime are *environment* and *state* - the of binding of names to locations (channels/variables) and of locations to values, respectively. Both are depicted in context of the rho-calculus semantics below.

[ State Diagram ]


An updated state configuration could be anything from updating a routine from blocking to non-blocking status to updating a location in local memory. A simple register update for example: 


::


    for ( Int <- register )P | register! ( 1 ) -> P { 1/Int }



The continuation :code:`P` in an environment where :code:`1` is substituted every occurance of :code:`Int`. If no further processing is desired, the continuation :code:`P` is the null process :code:`0`.

The above example depicts an alteration to local storage, but the monadic treatment of channels allows for much higher-level constructs. In addition to local storage, a channel may be bound to a network-wide advanced message queuing protocol (AMQP) or tcp/ip sockets, etc. For example, a node operator listening on a live data stream that is receiving transaction blocks:

How are state configuration and bytecode differences stored? **Bytecode instructions are applied to the members of a key-value database.** We are required to apply the consensus algorithm when node operators have differing configurations for the same instance of RhoVM.


::


    for ( ptrn <- stream ) | stream! ( block ) -> P { block/ptrn }


In this case, the I/O pair is satisfied by two node operators, one writing a block to a stream and one reading a block from a stream. The difference is that, in this use-case, node operators are communicating through an AMQP, where channels are network addresses instead of local memory addresses.

Regardless of how a channel is implemented, all binding alterations committed to the virtual machine, of names to locations (channels/variables) and of locations to values, are written to storage:

Executed bytecode instructions constitute transactions which are stored along with the information they alter and subjected to consensus to produce transaction blocks. By extension, transaction blocks represent the verifiable history of states and transitions of the virtual machine.

To summarize:

1. when we refer to RhoVM, we are referring to the composition of an execution engine and a key-value database. 
2. The rho-calculus I/O semantics, where channels correspond to keys, substitute one value for another.
3. Substitutions manifest differences in the VM bytecode. Those differences are subjected to consensus, and written to storage.

Scalability
-------------------------------------------------------------------

From the perspective of a traditional software platform, the notion of “parallel” VM instances is redundant; it is assumed that VM instances operate independently of each other. Hence, there is no "global" RhoVM. At any given moment, there is a multiplex of replicated VM instances running on nodes across the network - each executing and validating state transitions for their associated namespaces. Because an instance of RhoVM exists for each namespace, the distributed key-value database, which stores the state of the VM, also exists for each.

This design choice of many virtual machines executing "in parallel" constitutes system-level concurrency on the RChain platform, where instruction-level concurrency is given by Rholang. Hence, when this publication refers to a single instance of RhoVM, it is assumed that there are a multiplex of RhoVM instances simultaneously executing a different set of contracts in a different namespace.

Compilation Environment
================================================

To allow clients to execute on the VM, we’ll build a compiler pipeline that starts with Rholang source-code that is then compiled into intermediate representations (IRs) that are progressively closer to bytecode, with each translation step being either provably correct, commercially tested in production systems, or both. This pipeline is illustrated in the figure below:


.. figure:: ../img/compilation_strategy.png
    :width: 1200
    :align: center
    :scale: 50
    
    *Figure - RChain Compilation Strategy*
    
 
1. **Analysis**: From Rholang source-code, or from another smart contract language that compiles to Rholang, this step includes:

    a) analysis of computational complexity
    b) injection of code for the rate-limiting mechanism
    c) formal verification of transaction semantics
    d) desugaring of syntax
    e) simplification of functional equivalencies

2. **Transcompilation**: From Rholang source-code, the compiler:

    a) performs a simple source-to-source compilation from Rholang to Rosette source-code, which will eventually be executed on the     Rosette VM.

3. **Analysis**: From Rosette source-code, the compiler performs:
    
    a) lexical, syntactic, and semantic analysis of the Rosette syntax, construction of the AST; and
    b) synthesizes a Rosette intermediate representation

4. **Optimization**: From Rosette IR, the compiler:

    a) optimizes the IR via redundancy elimination, sub-expression elimination, dead-code elimination, constant folding, induction variable identification and strength simplification
    b) synthesizes bytecode to be executed on Rosette VM
    
For more details `join`_ the `#rhovm`_ channel on the RChain Slack here. Early compiler work can be seen on `GitHub`_.

.. _GitHub: https://github.com/rchain/Rosette-VM
.. _#rhovm: https://ourchain.slack.com/messages/coop/
.. _join: http://slack.rchain.coop/

What Is Rosette?
------------------------------------------------

Rosette is a reflective, object-oriented language that achieves concurrency via actor semantics. The Rosette system (including the Rosette virtual machine) has been in commerical production since 1994. Because of its demonstrated reliability, RChain Cooperative has committed to completing a clean-room reimplementation of Rosette VM in Scala. There are two main benefits of doing so. First, the Rosette language satisfies the instruction-level concurrency requirements demanded by a scalable design. Second, Rosette VM was intentionally designed to support multi-computer systems of an arbitrary amount of processors. For more information, see `Mobile Process Calculi for Programming the Blockchain`_. 

.. _Mobile Process Calculi for Programming the Blockchain: http://mobile-process-calculi-for-programming-the-new-blockchain.readthedocs.io/en/latest/

Execution Strategy
================================================

This section gives a high-level view of RChain's contract execution strategy.


.. figure:: .. /img/execution_diagram.png
    :width: 1792
    :align: center
    :scale: 50
    
    *Figure - RChain Execution Sequence*


This sequence portrays a client request for a contract that is sent to all node operators validating transactions for the superset of contracts in the namespace of the requested contract. On each node, the request is recieved by a VM system contract (thread) that handles work requests.


For brevity, this representation sidesteps the consensus requirement of each system contract. In practice, each system contract may posess many protocols that are themselves subject to consensus. During the course of each contract, many transactions will be requested and need to be committed before progress on other parts of the contract can be made.
 
    
Execution Environment - RhoVM
================================================

In the section on rho-calculus, we presented the rho-calculus reduction semantics as a faithful representation of an atomic transaction.


Rate-limiting Mechanism
---------------------------------------------------

RhoVM will implement a rate-limiting mechanism that is related to some calculation of processing, memory, storage, and bandwidth resources. This mechanism is needed in order to recover costs for the hardware and related operations. Although Bitcoin and Ethereum (Gas) have similar needs, the mechanisms are different. Specifically, the metering will not be done at the VM level, but will be injected in the contract code during the analysis phase of compilation.

Model Checking and Theorem Proving
----------------------------------------------------

In the RhoVM and potentially in upstream contracting languages, there are a variety of techniques and checks that will be applied during compile-time and runtime. These help address requirements such as how a developer and the system itself can know a priori that contracts that are well-typed will terminate. Formal verification will assure end-to-end correctness via model checking (such as in SLMC) and theorem proving (such as in Pro Verif). Additionally, these same checks can be applied during runtime as newly proposed assemblies of contracts are evaluated.

Discovery Service
----------------------------------------------------

An advanced discovery feature that will ultimately be implemented enables searching for compatible contracts and assembling a new composite contract from of other contracts. With the formal verification techniques, the author of the new contract can be guaranteed that when working contracts are plugged together they will work as well as a single contract.
