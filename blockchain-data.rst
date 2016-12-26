.. _blockchain-data:

################################################################################
Blockchain Data
################################################################################

Data Semantics
================================================================================

Like Ethereum, the RChain blockchain will store contracts and their serialized state. UTXO-style transactions will be implemented with simpler system-level contracts. Like Bitcoin and Ethereum, tamper-proof blockchain semantics will be used to create a history of blocks. The blockchain’s main purpose is to efficiently store essential state, any necessary sequencing, and timestamping.

Note that the math underlying this blockchain semantic structure is known as a
Traced Monoidal Category. For more detail see Masahito Hasegawa's paper on this
topic, `Recursion from Cyclic Sharing - Traced Monoidal Categories and Models of
Cyclic Lambda Calculi`_.

The RChain design considers all storage “conserved”, although not all data will be conserved forever. Instead, data storage will be leased and will cost producers of that data in proportion to its size, contract complexity, and lease duration. Unlike Bitcoin and Ethereum, immutable data is not promised to be truly forever; however, a very long lease duration is equivalent.

The simple economic reason justifying leasing is that storage must be paid by someone or it cannot be maintained. We’ve chosen to make the economic mechanism direct. It is really an environmentally unfriendly idea that storage is made "free" only to subsidize it by an unrelated process. A small part of the real cost is measurable in the heat signatures of the data centers that are growing to staggering size. This charging for data as it is accessed also helps reduce "attack" storage, the storage of illegal content to discredit the technology.

A variety of data is supported, including public unencrypted json, encrypted blobs, or a mix. This data can also reference off-platform data stored in private, consortium, public, or obscure locations and formats.

.. _Recursion from Cyclic Sharing - Traced Monoidal Categories and Models of Cyclic Lambda Calculi: http://www.kurims.kyoto-u.ac.jp/~hassei/papers/tlca97.pdf

Data Storage
===============================================================================

Data will be accessed using the SpecialK semantics and physically stored in a key-value database. A given node can choose which address namespaces it cares about, so not all data needs to be replicated in every node.

Addresses and Sharding/Compositionality
===============================================================================

In contrast to other blockchains, where addresses are public keys (or hashes
thereof), RChain’s address space will be structured. This is similar to how both
the Internet and the web works, with IP addresses and URLs, respectively. A
structured addressing approach allows programs to talk about “location” in a
much more nuanced and fine-grained way. This design choice enables fast datalog
queries based on those namespaces and better system performance by analyzing
communication patterns to optimize the sharding solution.

This sharding solution allows:

* Dynamic composable sharding based on namespace interaction
* Concurrent betting on and committing of blocks that don’t conflict.
* Clients to subscribe to select address spaces without downloading the entire blockchain. Able to impose different policies such as maximum transaction size on different address ranges.
* Arbitrary number of levels of address namespace.

For additional information, see Linear Types Can Change The Blockchain
(`pdf`_, `lex`_, `hangout video`_), which describes the inspirational math
and thinking in this area. Linear Types provide a nice way to decompose the
blockchain in a scalable fashion. It already has sharding semantics in it,
that is in the type system.

.. _pdf: https://github.com/leithaus/pi4u/blob/master/ltcctbc/ltcctbc.pdf
.. _lex: https://github.com/leithaus/pi4u/tree/master/ltcctbc
.. _hangout video: https://plus.google.com/u/0/events/cmqejp6d43n5cqkdl3iu0582f4k

Namespace Definition and Policy
===============================================================================

In order to support many of the use cases that users of Bitcoin find valuable as well as broader use cases, namespace definitions will have a corresponding policy set that constrains its use, for example by setting:

* maximum contract code size,
* maximum data size,
* minimum lease time,
* maximum lease time, and
* other parameters

With policies such as these, a namespace can be defined to provide better guarantees of fast transaction speed and immutability, for example.

Contract Ownership, Transactions, and Messages
===============================================================================

RChain’s contract accounts, transactions, and messages are analogous to `those in Ethereum`_.

.. _those in Ethereum: http://ethdocs.org/en/latest/contracts-and-transactions/account-types-gas-and-transactions.html

Rate-limiting Mechanism
===============================================================================

RChain’s VM will implement a rate-limiting mechanism that is related to some
calculation of processing, memory, storage, and bandwidth resources. This mechanism
is needed in order to recover costs for the hardware and related operations.
Although Bitcoin and Ethereum (gas) have similar needs, the mechanisms are different.
Specifically, the metering will not be done at the VM level, but will be injected
in the contract code (via source-to-source translation that is part of the compilation
process [#f1]_).

Tokens
===============================================================================

Somewhat similar to Omni Layer, multiple types of tokens will be supported. These tokens will have different properties depending on their type, including parameters such as:

* supply (initial supply, supply growth function, and final supply),
* fungibility, and
* other properties

For each type of token, there will be a link between its class (i.e., its set of distinguishing properties) and the rate-limiting mechanism.

.. [#f1] Ethereum 2.0 is intending on following the same technique.
