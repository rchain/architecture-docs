.. _namespaces:

*****************************************************************
Namespace Logic
*****************************************************************

RChain’s sharding mechanism is a natural and unique extension of the rho-calculus core model. In contrast to the two-level sharding approach taken by Ethereum, RChain’s virtual address space will be partitioned into "namespaces", where **a namespace is a collection of named processes and channels.**

The rho-calculus constructs named processes and named channels in the traditional sense of a name as an identifier, but leaves the implementation of the identifier undefined deliberately so that the model can be used to reason about a variety of system layers.

Namespaces exist at the network level as well:

The value proposition of namespaces is that they provide a consistent and formal logic for exponential and dynamic "sharding" solutions on a variety of architectural levels.

Within the storage component of RhoVM, names are implemented as keys in a key-value store that maintains the virtual address space for RChain.[ Stuff about key values ]

If a name is implemented as the ROOT_HASH key of a Merkle tree, and ROOT_HASH is not a terminal node, then ROOT_HASH is in fact a *namespace* that consists of the key-value bindings of its child nodes:
 
[ Diagram ]

Namespaces are morally equivalent to shards in that their motivation is to partition the blockchain’s address space into many smaller units which store contracts, execute transactions, and reach consensus independently of others.

Namespaces, however, are not limited to key-value stores. In fact, the rho-calculus leaves the implementation of an identifier undefined deliberately so that the model can be used to reason about a variety of system layers. Namespaces exist at the network level as well:

Sets of transactions that execute in separate namespaces may execute in parallel:

::

   for(ptrn1 <- x1){P1} | x1!(@Q1) | ... | for(ptrnn <- xn){Pn} | xn!(@Qn) → P1{ @Q1/ptrn1} | ... | Pn{ @Qn/ptrnn }

 | for(ptrn1 <- v1){P1} | v1!(@Q1) | ... | for(ptrnn <- vn){Pn} | vn!(@Q1) → P1{ @Q1/ptrn1} | ... | Pn{ @Qn/ptrnn }


The set of transactions executing over :code:`x`, and the set of transactions executing over :code:`v`, are double-blind; they are anonymous. Both sets of transactions communicate the same resource, :code:`@Q`, and noth match the same structural pattern, :code:`ptrn`, but no race condition occurs because the interactions occur in separate namespaces.

This approach to isolating sets of process/contract interactions essentially partitions RChain’s address space into many independent transactional environments, each of which are internally concurrent and may execute in parallel.


.. figure:: .. /img/blocks-by-namespace.png
    :align: center
    :width: 1950
    :scale: 80
    
    Figure - Namespaces as Isolated Transactional Environments
    

Of course, one issue with this approach is that resources are (possibly) available to processes/contracts which:

  i. know the name of the channel; and 
  ii. satisfy a pattern match.

If the address space has been partitioned into many isolated transactional environments, how can each of those environments further refine the type of contracts that interface with it? For that, we turn to definitions.

Namespace Definitions
============================================================
**A namespace definition is a formulaic description of the minimum conditions required for a process/contract to function in a namespace.** In point of fact, the consistency of a namespace is immediately and exclusively dependent on how that space defines a name, which may vary greatly depending on the intended function of the contracts the namespace definition describes.

A name satisfies a definition, or it does not; it functions, or it does not. The following namespace definition is implemented as an ‘if conditional’ in the interaction which depicts a set of processes sending a set of contracts to set of named addresses that comprise a namespace:


.. figure:: .. /img/namespace-definitions.png
    :align: center
    :width: 2659
    :scale: 80
    
    Figure - A Namespace Definition Implemented as an ‘If-conditional’
    
    

1. A set of contracts, :code:`contract1...contractn` , are sent to the set of channels (namespace) :code:`address1...addressn`.

2. In parallel, a process listens for input on every channel in the :code:`address` namespace. 

3. When a contract is received on any one of the channels, it is supplied to :code:`if cond.`, which checks the namespace origin, the address of sender, the behavior of the contract, the structure of the contract, as well as the size of data the contract carries. 

4. If those properties are consistent with those denoted by the, :code:`address`, namespace definition, continuation :code:`P` is executed with :code:`contract` as its argument.

A namespace definition effectively bounds the types of interactions that may occur in a namespace - with every contract existing in the space demonstrating a common and predictable behavior. That is, the state alterations invoked by a contract residing in a namespace are necessarily authorized, defined, and correct for that namespace. This design choice makes fast datalog-style queries against namespaces very convenient and exceedingly useful.

A namespace definition may control the interactions that occur in the space, for example, by specifying:

* Accepted Addresses
* Accepted Namespaces
* Accepted Behavioral Types
* Max/Min Data Size
* I/O Structure

A definition may, and often will, specify a set of accepted namespaces and addresses which can communicate with the agents it defines.

Note the check against behavioral types in the graphic above. This exists to ensure that the sequence of operations expressed by the contract is consistent with the safety specification of the namespace. Behavioral type checks may evaluate properties of liveness, termination, deadlock freedom, and resource synchronization - all properties which ensure maximally “safe” state alterations of the resources within the namespace. Because behavioral types denote operational sequencing, the behavioral type criteria may specify post-conditions of the contract, which may, in turn, satisfy the preconditions of a subsequent namespace. As a result, the namespace framework supports the safe composition, or "chaining" together, of transactional environments.

Composable Namespaces - Resource Addressing
=============================================================================
Until this point, we’ve described named channels as flat, atomic entities of arbitrary breadth. With reflection, and internal structure on named channels, we achieve depth.

A namespace can be thought of as a URI (Uniform Resource Identifier), while the address of a resource can be thought of as a URL (Uniform Resource Locator). The path component of the URL, :code:`scheme://a/b/c`, for example, may be viewed as equivalent to an RChain address. That is, a series of nested channels that each take messages, with the named channel, :code:`a`, being the “top” channel.

Observe, however, that URL paths do not always compose. Take :code:`scheme://a/b/c` and :code:`scheme://a/b/d`. In a traditional URL scheme, the two do not compose to yield a path. However, every flat path is automatically a tree path, and, as trees, these *do* compose to yield a new tree :code:`scheme://a/b/c+d`. Therefore, trees afford a composable model for resource addressing.


.. figure:: .. /img/namespaces-as-tree-paths.png
    :align: center
    :width: 1617
    :scale: 80
    
    Figure - Composable Tree Paths
    
    
Above, unification works as a natural algorithm for matching and decomposing trees, and unification-based matching and decomposition provides the basis of query. To explore this claim let us rewrite our path/tree syntax in this form:

::

 scheme://a/b/c+d ↦ s: a(b(c,d))


Then adapt syntax to the I/O actions of the rho-calculus:

::

                                                      s!( a(b(c,d)) )

                                                      for( a(b(c,d) <- s; if cond ){ P }
          
          
The top expression denotes output - place the resource address :code:`a(b(c,d)` at the named channel :code:`s`. The bottom expression denotes input. For the pattern that matches the form :code:`a(b(c,d))`, coming in on channel :code:`s`, if some precondition is met, execute continuation :code:`P`, with the address :code:`a(b(c,d)` as an argument. Of course, this expression implicates :code:`s`, as a named channel. So the adapted channel structure is represented:


.. figure:: .. /img/namespaces-as-trees.png
    :align: center
    :width: 567
    :scale: 60
    
    Figure - URL Scheme as Nested Channels in Tree Structure
    
    
Given an existing address structure, and namespace access, a client may query for and send to names within that address structure. For example, when the rho-calculus I/O processes are placed in concurrent execution, the following expression denotes a function that places the quoted processes, :code:`(@Q,@R)` at the location, :code:`a(b(c,d))`:

::

                                            for( a(b(c,d) ) <- s; if cond){ P } | s!( a(b(@Q,@R)) )


The evaluation step is written symbolically:

::

                                   for( a(b(c,d)) <- s; if cond ){ P } | s!( a(b(@Q,@R)) ) → P{ @Q := c, @R := d }


That is, :code:`P` is executed in an environment in which :code:`c` is substituted for :code:`@Q`, and :code:`d` is substituted for :code:`@R`. The updated tree structure is represented as follows:


.. figure:: .. /img/tree-structure-substituted.png
    :align: center
    :width: 1688
    :scale: 80
    
    Figure - Placing Processes at Channels


In addition to a flat set of channels e.g :code:`s1...sn` qualifying as a namespace, every channel with internal structure is, in itself, a namespace. Therefore, :code:`s`, :code:`a`, and :code:`b` may incrementally impose individual namespace definitions analogous to those given by a flat namespace. In practice, the internal structure of a named channel is an n-ary tree of arbitrary depth and complexity where the "top" channel, in this case :code:`s`, is but one of many possible names in :code:`s1...sn` that possess internal structure.

This resource addressing framework represents a step-by-step adaptation to what is the most widely used internet addressing standard in history. RChain achieves the compositional address space necessary for private, public, and consortium visibility by way of namespaces, but the obvious use-case addresses scalability. Not by chance, and not surprisingly, namespaces also offer a framework for RChain’s sharding solution.


.. [5] Namespace Logic - A Logic for a Reflective Higher-Order Calculus.

