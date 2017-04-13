##########################################
Introduction
##########################################

The open source RChain project is building a public, Sybil-resistant and censorship-resistant computing infrastructure based on decentralized blockchain concept. Ultimately, RChain will host and execute the blockchain programs popularly referred to as "smart contracts".

Using smart contracts, a broad array of fully-scalable decentralized applications (dApps) can be built on the top of this platform. DApps may address areas such as identity, tokens, financial servers, monetized content delivery, Decentralized Autonomous Organizations (DAOs), exchanges, reputation, private social networks, marketplaces, and many more.


.. figure:: ../img/architecture-overview.png
   :align: center
   :width: 1050
   :scale: 80

    Figure: High-level RChain Architecture


The RChain Network implements direct node-to-node communication, where each node runs the RChain platform and a set of dApps on the top of it. The heart of an RChain node is written in Scala and runs on one or more instances of the concurrent **Rho Virtual Machine (RhoVM)** that executes on top of the JVM. An instance of RhoVM is very light-weight. Theoretically, an independent RhoVM exists for every set of independently executing contracts i.e. contracts that do not compete for resources.

This design choice of numerous, independently executing virtual machine instances constitutes machine-level concurrency on the RChain platform. It is also in direct contrast to a “global compute” design which constrains transactions to be executed sequentially, on a single virtual machine, notwithstanding their associated dependencies. Hence, where there is a discussion held in this publication concerning a single instance of RhoVM, it is assumed that there are a multiplicity of RhoVM instances executing in parallel, for different sets of contracts.

The state of an instance of RhoVM is verified by implementing a variant of the **Casper Proof-of-Stake (PoS)** consensus/replication algorithm. An array of node operators, or "bonded validators", run the same instance of RhoVM. They apply the consensus algorithm to crypto-economically verify that the entire history of state configurations and state transitions, of the RhoVM instance, are accurately replicated in a distributed, append-only data store.

The emergent platform components and contracts (aka smart contracts, processes, or programs) are written in the RChain general purpose language, “**Rholang**” (Reflective higher-order language). Derived from the rho-calculus computational formalism, Rholang supports internal programmatic concurrency. It formally expresses the communication and coordination of many processes executing in parallel composition. Rholang naturally accommodates industry trends in code mobility, reactive/monadic API’s, parallelism, asynchronicity, and behavioral types.
