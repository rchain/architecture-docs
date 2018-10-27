##########################################
Introduction
##########################################

The open-source RChain project is building a *decentralized, economic, censorship-resistant, scalable, public compute infrastructure and blockchain with proof-of-stake consensus. It will host and execute programs popularly referred to as "smart contracts", and serve as a content delivery system.

A broad array of fully-scalable decentralized applications (dApps) can be built on the top of this platform and inherit its properties. DApps may provide solutions in fields such as identity, tokens, timestamping, financial services, monetized content delivery, Decentralized Autonomous Organizations (DAOs), exchanges, reputation ledgers, social networks, marketplaces, and many more and many others.


.. figure:: ../img/architecture-overview.png
   :align: center
   :width: 1135
   :scale: 50

   Figure: High-level RChain Architecture

The RChain Network implements direct node-to-node communication, where each node runs the RChain platform and a set of dApps on the top of it.

The heart of RChain is the Rho Virtual Machine (RhoVM) Execution Environment, which runs multiple multi-threaded RhoVMs concurrently.

This concurrency, along with an application of compositional namespaces, allows for what are in effect multiple blockchains per node. This multi-chain of independently executing virtual machine instances is in sharp contrast to a “global compute” design which constrains transactions to be executed sequentially, on a single virtual machine.
Each node can be configured to subscribe to and process the namespaces (blockchains) in which it is interested.

Like other blockchains, achieving consensus across nodes on the state of the blockchain is essential. RChain's protocol for replication and consensus is called Casper and is a proof-of-stake protocol.
Similar to Ethereum, a contract starts out in one state, a node receives a signed transaction, and then its RhoVM instances execute that contract to its next state.
An array of node operators, or "bonded validators" apply the consensus algorithm to crypto-economically verify that the entire history of state configurations and state transitions of the RhoVM instance are accurately replicated in a distributed data store.

The blockchain contracts (aka smart contracts, processes, or programs) and system contracts that come with the installation are written in the RChain general-purpose language, **Rholang** (Reflective higher-order language). Derived from the rho-calculus computational formalism, Rholang supports internal programmatic concurrency. It formally expresses the communication and coordination of many processes executing in parallel composition. Rholang naturally accommodates industry trends in code mobility, reactive/monadic API’s, parallelism, asynchronicity, and behavioral types.

Since nodes are internally concurrent, and each need not run all namespaces (blockchains), the system will be *scalable*.

Since the contract language and its VM are build from the formal specifications of provable mathematics, and since the compiler pipeline and engineering approach is *correct by construction*, we expect the platform will be regarded as *trustworthy*.
