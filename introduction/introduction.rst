##########################################
Introduction
##########################################

The open source RChain project is building a public, Sybil-resistant and censorship-resistant computing infrastructure based on decentralized blockchain concept. Ultimately, RChain will host and execute the blockchain programs popularly referred to as "smart contracts". 

Using smart contracts, a broad array of fully-scalable decentralized applications (dApps) can be built on the top of this platform. DApps may address areas such as identity, tokens, financial servers, monetized content delivery, Decentralized Autonomous Organizations (DAOs), exchanges, reputation, private social networks, marketplaces, and many more.

Figure - High-level RChain Architecture


The RChain Network implements direct node-to-node communication, where each node runs the RChain platform and a set of dApps on the top of it. The heart of an RChain node is written in Scala and runs on one or more instances of the concurrent **Rho Virtual Machine (RhoVM)** that executes on top of the JVM. An instance of RhoVM is very light-weight. Theoretically, an independent RhoVM exists for every set of independently executing contracts i.e contracts that do not compete for resources. 

This design choice of many concurrent virtual machines is top-level concurrency on the RChain platform. It is also in direct contrast to a “global compute” design which constrains transactions to be executed sequentially, on a single virtual machine notwithstanding their associated dependencies. Hence, where there is a discussion held in this publication concerning a single RhoVM, it is assumed that there are a multiplex of RhoVMs executing the same protocols in parallel for a different set of contracts.

The state of an instance of RhoVM is verified by implementing a variant of the **Casper Proof-of-Stake (PoS)** consensus/replication algorithm which is, itself, executed on that instance of RhoVM. Therefore, many nodes may run and validate the same instance of RhoVM.

The emergent platform components and contracts (aka smart contracts, processes, or programs) are written in the RChain general purpose language “**Rholang**” (**R** eflective **h** igher-**o** rder language). Derived from the rho-calculus computational formalism, Rholang concretizes granular concurrency on the RChain platform. It programmatically expresses the interactions of communicating and mobile processes executing in parallel composition. Rholang naturally accommodates industry trends in code mobility, structural pattern matching, process continuation, Reactive API’s, parallelism, asynchronicity, and spatial-behavioral types.
