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

Data Semantics
----------------------------------------

The RChain blockchain will store contract state, the local transaction history of a contract, and the awaiting continuations associated with a contract. Like Ethereum, the RChain blockchain will also implement crypto-economically verifiable transactional semantics to create a linear temporal history of computation performed on the platform. Note that the math underlying this blockchain semantic structure is known as a Traced Monoidal Category. For more detail see Masahito Hasegawa's paper on this topic, `Recursion from Cyclic Sharing:Traced Monoidal Categories and Models of Cyclic Lambda Calculi`_.

.. _Recursion from Cyclic Sharing:Traced Monoidal Categories and Models of Cyclic Lambda Calculi: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.52.31&rep=rep1&type=pdf

Data will be accessed using the SpecialK semantics and physically stored in a key-value database. A given node can choose which address namespaces it cares about, so not all data needs to be replicated in every node.

The RChain design considers all storage “conserved”, although not all data will be conserved forever. Instead, data storage will be leased and will cost producers of that data in proportion to its size and duration. Unlike Bitcoin and Ethereum, immutable data is not promised to be truly forever. However, a very long lease duration is equivalent. 

The simple economic reason justifying leasing is that storage must be paid by someone or it cannot be maintained. We’ve chosen to make the economic mechanism direct. It is really an environmentally unfriendly idea that storage is made "free" only to subsidize it by an unrelated process. A small part of the real cost is measurable in the heat signatures of the data centers that are growing to staggering size. This charging for data as it is accessed also helps reduce "attack" storage, the storage of illegal content to discredit the technology.

A variety of data is supported, including public unencrypted json, encrypted blobs, or a mix. This data can also reference off-platform data stored in private, consortium, public, or obscure locations and formats.

P2P Node Communications
---------------------------------------------

The SpecialK decentralized storage semantics necessitate a node communications infrastructure. Similar to other decentralized implementations, the P2P communications component handles node discovery, inter-node trust, and communication. A number of other platform-level protocols will be developed, such as those related to security, node trust, and communications.

Content Delivery Network
----------------------------------------------

This layer will track access and storage of content. Software clients will be required to pay for creation, storage, and retrieval of all content delivered to/from the CDN, via microtransactions. Since storing and retrieving content is not free, why should a technical solution make it free to users like centralized solutions that subsidize the cost in indirect ways? With the promise of micropayments, the RChain platform can more directly charge for the storage and retrieval of content.
