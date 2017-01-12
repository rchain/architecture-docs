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


.. figure:: https://github.com/rchain/architecture-docs/blob/develop/img/57444266.png
   :align: center


This model depicts two contracts, which both may receive and send messages. Eventually, Contract\ :sub:`1` is prompted to send a value, v, on the channel ‘Address’ which is the address of Contract\ :sub:`2`. Meanwhile, Contract\ :sub:`2` listens on its address channel for some value v. After it receives some value, v, Contract\ :sub:`2` invokes some process continuation with v as an argument. These last two steps occur sequentially. 

Note that, this model assumes that at least the sender possesses the address of Contract\ :sub:`2`. Also note that, after it sends v, Contract\ :sub:`1` has been run to termination, thus it is incapable of sending anything else unless prompted. Similarly, after it invokes a continuation, Contract\ :sub:`2` has been run to termination, thus it is incapable of listening for any other messages.

RChain contracts enjoy fine-grain, internal concurrency, which means that these processes, and any processes that are not co-dependent, may be placed in parallel composition. So, we amend our notation:

.. figure:: https://github.com/rchain/architecture-docs/blob/develop/img/82846984.png
   :align: center

Executing in parallel with a number of other processes, Contract\ :sub:`1` is prompted to send a value, v, on the channel ‘Address’ i.e the address of Contract\ :sub:`2`. If Contract1 has no value to send, then the process is inert. If Contract\ :sub:`2` has not received a value, then its continuation is not triggered and it is inert. Thus, Contract\ :sub:`1` and Contract\ :sub:`2` may execute asynchronously and in parallel. Additionally, message passing is an atomic operation. Either a message is transmitted, or it is not.

Transactions
-------------------------------------------------------------

How do transaction semantics fit into our description of contracts? **From the process level, a transaction is an acknowledgment that two agents have successfully exchanged a message over a channel.**

Messages themselves are virtual objects, but the pre-state and post-state of a contract, referring to the states before and after a message is sent by one agent and received by another, are verified and written to blockchain storage.

Only the successful transmission of a message qualifies as a verifiable transaction that can be included in a block. Examples hitherto depict atomic protocols, but full-bodied applications may spawn, send, and receive on ten’s of thousand’s of channels at runtime. Hence, when a resource is transferred from one agent to another, even in larger systems, there is record of when and where it went. This implementation is consistent with an interpretation of data as a linear resource.

PICTURE3

This model of transaction favorably lends itself to information flow analysis and optimization between addresses. The ability to place a message at either end of a channel before and after the message is sent, and therefore to view the serialized form of messages, is an attribute specific to RChain. Additionally, by stating successful messages as transactions, all messages, whether from external user to contract or between contracts, are accounted for. Thus, we balance the extensible autonomy of contracts with accountability.

For an example of how this model is adaptable to industry trends in reactive programming, observe the following two contracts, which model interaction over “live” data streams:

PICTURE3

Executing in parallel composition with a number of other processes, Contract\ :sub:`1` is prompted to send a set of  values, v\ :sub:`N`, on the channel ‘Address’ i.e the address of Contract\ :sub:`2`. In this scenario, the reader will notice Contract\ :sub:`2` as a thread which takes a set of values as input from a single data stream that is dual to a set of values being output from a stream at its tail. As each value is received, a continuation is invoked with the value as an argument. While the interaction between Contract\  :sub:`1` and Contract\ :sub:`2` is asynchronous, the “receive” and “continuation” operations of Contract\ :sub:`2` are necessarily sequential. Thus, asynchronicity is preserved. 

We have presented a very basic depiction of concurrent contract interaction on the RChain platform to include contracts, addresses i.e channels of communication, and transactions i.e the successful transmission of a message. Next, we outline the core system which formally models these constructs.
