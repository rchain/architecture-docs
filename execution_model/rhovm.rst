.. _rhovm:

******************************************************************
Execution Model
******************************************************************

Introduction
==================================================================

To begin, a client writes a program (contract) in Rholang. The contract is compiled and passed to an instance of the **Rho Virtual Machine** (RhoVM) and executed. Given an environment and runnable bytecode, RhoVM realizes computation by repeatedly applying rho-calculus reduction semantics to elements of a key-value database, where a named channel is a key and a value may be a variable, a data structure, or the code of a contract.

Scalability
-------------------------------------------------------------------

From the perspective of a traditional software platform, the notion of “parallel” VM instances is redundant; it is assumed that VM instances operate independently of one another. Hence, there is no global “RhoVM”. At any given moment there is a multiplex of replicated VM instances running on nodes across the network - each executing and validating state transitions for their associated namespaces. Because an instance of RhoVM exists for every namespace,  a distributed key-value database also exists for every namespace.

This design choice of many virtual machines executing "in parallel" constitutes system-level concurrency on the RChain platform, where processor and instruction-level concurrency are given by Rholang. It is also in direct contrast to the “global virtual machine” model which constrains every state transition, defined by every contract on the platform, to be executed *sequentially*, notwithstanding their associated dependencies. Hence, where there is a discussion held in this publication concerning a single RhoVM, it is assumed that there are a multiplex of RhoVMs executing in parallel for a different set of contracts in a different namespace.

Compilation Environment
================================================

Necessarily, RhoVM is derived from the rho-calculus. Thus, there will be a tight coupling between Rholang and its VM, ensuring correctness. To allow clients to execute on the VM, we’ll build a compiler pipeline that starts with Rholang code that is then compiled into intermediate representations (IRs) that are progressively closer to bytecode, with each translation step being either provably correct, commercially tested in production systems, or both. This pipeline is illustrated in the figure below:


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

Rosette is a reflective, object-oriented language that achieves concurrency via actor semantics. The Rosette system (including the Rosette virtual machine) has been in commerical production since 1994. Because of its demonstrated reliability, RChain Cooperative has committed to completing a clean-room reimplementation of **Rosette VM** in Scala. There are two main benefits of doing so. First, the Rosette language satisfies the instruction-level concurrency requirements demanded by a scalable design. Second, Rosette VM was intentionally designed to support multi-computer systems of an arbitrary amount of processors. For more information, see `Mobile Process Calculi for Programming the Blockchain`_. 

.. _Mobile Process Calculi for Programming the Blockchain: http://mobile-process-calculi-for-programming-the-new-blockchain.readthedocs.io/en/latest/

Execution Strategy
================================================

.. figure:: .. /img/execution_diagram.png
    :width: 1792
    :align: center
    :scale: 50
    
    *Figure - RChain Execution Sequence*

This sequence portrays a request for a contract that is sent to the node operators validating transactions in that namespace. On each node, the request is recieved by the virtual machine system thread that handles work requests.

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
