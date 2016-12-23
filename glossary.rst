********************************************************************************
Glossary
********************************************************************************

.. glossary::
   :sorted:

   address
     An address is the location of an agent, where an agent may be a contract or a user.

   channel
     An instantialized public/private communication link between two addresses that may exist
     within the same process, concurrent processes, and across the network. Channels are cheap
     to create, send, and destroy.

   concurrency
     The composition of independently operating processes

   smart contract
     Loosely referred to as *contract*, a smart contract is a process, with a discrete
     state value, that resides at an address (i.e., a specific name) on RChain.
     Important to remember is that the term *contract* may refer to an atomic operation,
     or to a superset of chained operations which compose to form a larger contract.

   message
     Messages are non-serialized virtual objects. As such, they are not blockchain transactions,
     but runtime function calls that are called by contracts, and only exist between contracts.
     Messages come with a {rtn} address and, possibly, argument values. Messages can {get}, {set}
     and send objects, between addresses. However, unlike any other smart contracting platform,
     RChain implements a high-level, concurrent, message-passing paradigm as the foundational formalism
     for its contracting language. The language semantics are discussed at length in the Contract
     Execution section, but for now, it’s sufficient to understand that messages in Rholang have a
     very special set of additional properties: A message is issued over instantiated, encrypted
     channels which can communicate objects, which may be values, the names of channels, data
     structures and full-form protocols

   state
     The internal value of a data store. Term should be interpreted within usage contexts
     of: *Global state* - the state of the entire blockchain and *Contract state* - the
     state of the contract of discussion

   transaction
     A transaction is a crypto-economically verified acknowledgment that a state transition,
     requested by an agent, has occurred somewhere on the blockchain.
