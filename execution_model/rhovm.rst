.. _rhovm:

******************************************************************
Execution Model
******************************************************************

To begin, a client writes a program (contract) in Rholang. The contract is compiled and passed to an instance of the Rho Virtual Machine (RhoVM) and executed.

This virtual machine is derived from the computational model of the language, similar to other programming languages such as Scala and Haskell. In other words, there will be a tight coupling between Rholang and its VM, ensuring correctness. To allow clients to execute system transitions on the VM, we’ll build a compiler pipeline that starts with Rholang code that is then compiled into intermediate representations (IRs) that are progressively closer to bytecode, with each translation step being either provably correct, commercially tested in production systems, or both. This pipeline is illustrated in the figure below:


.. figure:: ../img/execution_strategy.png
    :width: 1200
    :align: center
    :scale: 80
    
    Figure - RChain Execution Strategy
    
    
Let’s describe these steps in more detail:

1. **Analysis**: From Rholang source-code, or from another smart contract language that compiles to Rholang, this step includes:

    a) injection of code for the rate-limiting mechanism
    b) formal verification of transaction semantics
    c) desugaring of syntax
    d) simplification of functional equivalencies


2. **Transcompilation**: From Rholang source-code, the compiler:

    a) performs a simple source-to-source compilation from Rholang to Rosette source-code, which will eventually be executed on the     Rosette VM.


3. **Analysis**: From Rosette source-code, the compiler performs:
    
    a) lexical, syntax, and semantics analysis of the Rosette syntax, constructs an AST and;
    b) synthesizes a Rosette intermediate representation


4. **Optimization**: From Rosette IR, the compiler:

    a) optimizes the IR via redundancy elimination, sub-expression elimination, dead-code elimination, constant folding, induction variable identification and strength simplification
    b) synthesizes bytecode to be executed on Rosette VM
    
    
5. **Execution**: Once passed to Rosette VM, the interpreter:

    a) retrieves (environmental variables)??? from decentralized storage layer
    b) translates Rosette bytecode to Java bytecode
    c) 
    d) returns the updated contract to the storage layer in bytecode form
    
For more details see the #rholang channel on the RChain Slack `here`_. Early compiler work can be seen on `GitHub`_.

.. _GitHub: https://github.com/rchain/Rosette-VM
.. _here: https://ourchain.slack.com/messages/coop/


Formal Specification
----------------------------------------------------

Rholang will be formally specified, and we are investigating a few frameworks such as `K-Framework`_ to achieve this.

.. _K-Framework: http://www.kframework.org/index.php/Main_Page


Model Checking and Theorum
----------------------------------------------------
In the RhoVM and potentially in upstream contracting languages, there are a variety of techniques and checks that will be applied during compile-time and runtime. These help address requirements such as how a developer and the system itself can know a priori that contracts that are well-typed will terminate.
Formal verification will assure end-to-end correctness via model checking (such as in SLMC) and theorem proving (such as in Pro Verif). Additionally, these same checks can be applied during runtime as newly proposed assemblies of contracts are evaluated.


Discovery Service
----------------------------------------------------
An advanced discovery feature that will ultimately be implemented enables searching for compatible contracts and assembling a new composite contract from of other contracts. With the formal verification techniques, the author of the new contract can be guaranteed that when working contracts are plugged together they will also work together.


SpecialK: Data & Continuation Access, Cache
=====================================================
The current "RChain 1.0" technology stack delivers a decentralized CDN. Its primary component is SpecialK, which sits on top of MongoDB and RabbitMQ to create the decentralized logic for storing and retrieving content, both locally and remotely.

SpecialK implements distributed data-access patterns in a consistent way, as shown below:


*Figure - Persisted, Continuation-based Data Access Patterns for SpecialK*


A view of how two nodes collaborate to respond to a get request is shown below: 


*Figure - Decentralized data access in SpecialK*


1) The first node checks its in-memory cache, then if it is not found 
2) checks its local store, then if it is not found stores a delimited continuation at that location, and 
3) checks the network.  When the network returns data, the delimited continuation is brought back in scope with the retrieved data as its parameter.

With the RChain platform, the implementation of the CDN will also evolve, although not in its fundamental design.


Content Delivery Network
----------------------------------------------
This layer will track access and storage of content. Software clients will be required to pay for creation, storage, and retrieval of all content delivered to/from the CDN, via microtransactions. Since storing and retrieving content is not free, why should a technical solution make it free to users like centralized solutions that subsidize the cost in indirect ways? With the promise of micropayments, the RChain platform can more directly charge for the storage and retrieval of content.


Attention and Reputation Economy
====================================================
From a user-centric perspective, this economy aims to directly but unobstructedly allow value to be placed on the content’s creation, consumption, and promotion. This applies to many types of content.  For example, a short textual post is created, sent to an initial distribution list, read, promoted (liked), and made available to even more readers. Or, a short movie can go through the same workflow. Along these paths, attention is given, and rewards can flow back to the content originator and to promoters. Based on one’s own engagement with the content exchanged to/from one’s connections, each connection’s reputation is computed. The reputation rank can be used subsequently to present content in a manner consistent with how the user has demonstrated attention in the recent past.


*Figure - Attention & Reputation Economy Concept*


For more information, see the original whitepaper, `RChain: The Decentralized and Distributed Social Network`_. The latest thinking about Attention & Reputation Economy will be described in Slack discussions and blog posts.


Applications
-----------------------------------------------
Any number and variety of applications can be built on top of the RChain Platform that provide a decentralized public compute utility. These include, for example:

* Wallets
* Exchanges
* Oracles & External Adapters
* Custom Protocols
* Smart Contracts
* Smart Properties
* DAOs
* Social Networks
* Marketplaces

Several application providers are already committed to this platform, including `RChain`_ for its social product, `LivelyGig`_ for its marketplaces, `weWOWwe`_ for its sports-based social network, and `Nobex Radio`_ for a to-be-announced product.


Contract Development & Deployment
================================================
The purpose of this next discussion is to illustrate how namespaces allow for heterogeneous deployment of contracts and contract state. Namespaces is one of the crucial features for sharding, and with that we get the benefits analogous of sidechains, private chains, consortium chains, as well as the distinction between test and production, all under one rubric.

For example, the following diagram depicts some of the possible development, test, and deployment configurations and considerations, and how release management is enabled using namespaces and sharding.


*Figure - Development & Deployment Possibilities*


We’ll collaborate with IDE tool vendors to integrate Rholang and validation tools. 


Governance
-----------------------------------------------
Like other open source and decentralized projects, and especially those involving money and blockchains, the RChain Platform components will require they be created, tested, released, and evolved with great care. RChain’s leadership fully intends to help define these governance processes and to empower a public community to enforce them.

Call for Participation
***********************************************
We invite you to participate in RChain's Slack channels, joining via https://ourchain.slack.com/messages/coop/_. We require a variety of talent, but most urgently programmers with language development, formal methods, and, ideally, mobile process calculi and functional programming experience. Or, individuals who can demonstrate their ability to quickly learn these disciplines. We need investors to help fund the building out of this architecture. Contact Lucius Gregory Meredith <lgreg.meredith@gmail.com> and / or Ed Eykholt <ed.eykholt@livelygig.com> for more information.
