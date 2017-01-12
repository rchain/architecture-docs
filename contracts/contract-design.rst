.. _contract-design:

################################################################################
CONTRACT DESIGN
################################################################################

An RChain contract is a well-specified, well-behaved, and formally verified program that interacts with other well-specified, well-behaved, and formally verified programs.

In this section on contract design, we cover contract interaction through the production of Rholang. To begin, we give an overview of contract interaction on the RChain platform. Afterwards, we describe the core formalism RChain uses to achieve formal verification and to model concurrency on many of RChain’s system layers. Then, we explore how that core model extends to accomodate best-in-industry surface-language standards such as reflection, parallelism, asynchronicity, reactive data streams, and compile-time security-type checks. Finally, we give an application for a nested and composable resource addressing structure to partition transactional environments across RChain.

Contract Overview
======================================================================================
Used loosely as ‘contract’, **a smart contract is a process with:** 

1. Persistent state
2. Associated code
3. An associated RChain address(s)
4. An associated Phlogiston balance

Important to remember is that a smart contract is of arbitrary complexity; it may refer to an atomic operation, or to a superset of chained operations which compose to form a complex contract.

A contract is triggered by input, in the form of a message, from other network agents, where an agent may be a contract or an external actor.

**A Message:**

1. Is issued over an instantiated, encrypted channel(s) that may be public or private.
2. May communicate a return address for the sender.
3. May communicate a value, a channel, **or the serialized code of a process.**

There is no restriction barring a contract from sending and receiving messages to and from itself.

**Agents send and receive messages on named communication links known as ‘named channels’.** A contract may send and receive on multiple channels. **A blockchain address is a named channel** i.e a location(s) where an agent may be reached.

Two contracts sending and receiving a message on the channel named ‘Address’: 
