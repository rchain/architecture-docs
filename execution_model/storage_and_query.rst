.. _storage_and_query:

************************************************************
Storage and Query
************************************************************

Overview
----------------------------------------

The goal of this layer is to look like a local database with leased storage, asynchronously accessed, and to implement behind the scenes the aspects of decentralization and consensus. In accordance with the micro-transaction capabilities inherent to blockchain solutions, dApp users on RChain pay for resources (compute, bandwidth, storage) using tokens. The RChain design considers all storage “conserved”, although not all data will be conserved forever. Instead, data storage will be leased and will cost producers of that data in proportion to its size, contract complexity, and lease (or rent) duration. Consumers will also pay for retrieval access. Data producers and consumers indirectly pay node operators.

The simple economic reason justifying leasing is that storage must be paid by someone; otherwise it cannot be stored reliably or “forever”. We’ve chosen to make the economic mechanism direct. It is an environmentally unfriendly idea that storage is made "free" only to subsidize it by an unrelated process. A small part of the real cost is measurable in the heat signatures of the data centers that are growing to staggering size. This charging for data as it is accessed also helps reduce "attack" storage, i.e., the storage of illegal content to discredit the technology.

A variety of data is supported, including public unencrypted json, encrypted BLOBs, or a mix. This data can also be simple pointers or content-hashes referencing off-platform data stored in private, public, or consortium obscure locations and formats.

Data Semantics
----------------------------------------

The RChain blockchain will store contract state, the local transaction history of a contract, and the awaiting continuations associated with a contract. Like Ethereum, the RChain blockchain will also implement crypto-economically verifiable transactional semantics to create a linear temporal history of computation performed on the platform. Note that the math underlying this blockchain semantic structure is known as a Traced Monoidal Category. For more detail see Masahito Hasegawa's paper on this topic, `Recursion from Cyclic Sharing:Traced Monoidal Categories and Models of Cyclic Lambda Calculi`_.

.. _Recursion from Cyclic Sharing:Traced Monoidal Categories and Models of Cyclic Lambda Calculi: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.52.31&rep=rep1&type=pdf

============================================
SpecialK: DSL for Data Access
============================================

SpecialK is the DSL for data access, and KVDB is the decentralized implementation behind the DSL. SpecialK defines distributed data-access patterns in a consistent way, as shown below:



.. table:: Figure - SpecialK’s Data Access Patterns

+----------------------+-----------------------------------------------------+-----------------------------+-----------------------------------+--------------------------------------+
|                      | **Item-level read and write (distributed locking)** | **Database read and write** | **Publish / Subscribe messaging** | **Publish / Subscribe with history** |
+======================+=====================================================+=============================+===================================+======================================+
| **Data**             | Ephemeral                                           | Persistent                  | Ephemeral                         | Persistent                           |
+----------------------+-----------------------------------------------------+-----------------------------+-----------------------------------+--------------------------------------+
| **Continuation(K)** | Ephemeral                                           | Ephemeral                   | Persistent                        | Persistent                           |
+----------------------+-----------------------------------------------------+-----------------------------+-----------------------------------+--------------------------------------+
| **Producer Verb**    | Put                                                 | Store                       | Publish                           | Publish with History                 |
+----------------------+-----------------------------------------------------+-----------------------------+-----------------------------------+--------------------------------------+
| **Consumer Verb**    | Get                                                 | Read                        | Subscribe                         | Subscribe                            |
+----------------------+-----------------------------------------------------+-----------------------------+-----------------------------------+--------------------------------------+


*Figure - SpecialK’s Data Access Patterns*



From the point of view of the SpecialK DSL and API, when it performs a data-access action, such as the verb Get (with a pattern), it doesn’t need to know or care whether it is stored locally or going out to the network. There is a single query mechanism regardless.

The 2016 and prior SpecialK technology stack (Agent Services, SpecialK, and KVDB, with RabbitMQ and MongoDB) delivered a decentralized Content Delivery Network, although it was neither metered nor monetized. The SpecialK & KVDB components sit on top of MongoDB and RabbitMQ to create the decentralized logic for storing and retrieving content, both locally and remotely. The current 1.0 implementations of SpecialK and KVDB are written in Scala and are in `GitHub`_.

.. _GitHub:https://github.com/leithaus/SpecialK

The query semantics vary depending on which level in the architecture is involved. At the SpecialK level, prolog expressions are stored as part of the key and subsequently queried via prolog (datalog) expressions. Higher up in the architecture, prolog expressions of labels are used for storage, and datalog expressions of labels are used for query.

In RChain, the SpecialK and KVDB layers will be reimplemented in Rholang (versus the prior implementation in Scala with custom implementation of delimited continuations and code serialization).

**For more information, see `SpecialK/KVDB – A Pattern Language for the Web`_.** LINK

=====================================================
KVDB - Data & Continuation Access, Cache
=====================================================

KVDB is a Decentralized Key-Value Database. A view of how two nodes collaborate to respond to a get request is shown below: 

**Figure - Decentralized data access in SpecialK** PICTURE

1) The first node checks its in-memory cache. Then if it is not found it,

2) checks its local store, and if it is not found stores a delimited continuation at that location, and 

3) checks the network. When the network returns data, the delimited continuation is brought back in scope with the retrieved data as its parameter.

A frequent question about the 2016 RChain stack is, why it did not select IPFS (InterPlanetary File System). IPFS uses a path to get to content, whereas SpecialK uses whole trees (and trees with holes in them) to get to content. IPFS has an intuitive path model, but that design begs the question on how to do queries. SpecialK started from the query side of addressing. Now, the RChain project can benefit from the IPFS work, including their hashing for addressing content, once the SpecialK query semantics are in place. SpecialK can also utilize a randomly generated flat key that has no correlation to the data.

P2P Node Communications
---------------------------------------------

The SpecialK decentralized storage semantics necessitate a node communications infrastructure. Similar to other decentralized implementations, the P2P communications component handles node discovery, inter-node trust, and communication. The current implementation uses RabbitMQ, although ZeroMQ is being considered. A number of other platform-level protocols will be developed, such as those related to security, node trust, and communications.

Content Delivery Network
----------------------------------------------

This layer will track access and storage of content. Software clients will be required to pay for creation, storage, and retrieval of all content delivered to/from the CDN, via microtransactions. Since storing and retrieving content is not free, why should a technical solution make it free to users like centralized solutions that subsidize the cost in indirect ways? With the promise of micropayments, the RChain platform can more directly charge for the storage and retrieval of content.
