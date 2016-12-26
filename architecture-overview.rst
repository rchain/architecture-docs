.. _architecture-overview:

################################################################################
Architecture Overview
################################################################################

The primary components of the architecture are depicted below:

.. image:: img/architecture-overview.png
    :width: 600px
    :align: center

Like all "layer cake" views of architecture, this diagram is a simplification of the actual architecture. At first glance, you’ll notice there are components expected in blockchain architectures, but also components that might not be as expected All data managed by the platform requires some associated payment. Of course, an application could also manage its own data, and that data could be referenced via a pointer stored on the blockchain.

In addition to the datastore at the base of the architecture, a consensus protocol and peer-to-peer gossip network form the foundation.

Above that, the SpecialK Data & Continuation Access and Cache layer is  an evolution of the existing SpecialK technology (including its decentralized content delivery, key-value database, inter-node messaging, data access patterns, and privacy protecting agent model).

The Casper consensus protocols assure that nodes reach agreement about the contracts, contract state, and transactions for which each node is interested.

Blockchain contracts (aka smart contracts, protocols, or programs) will be written in a new domain-specific language for contracts called Rholang (or in contract languages that compile to Rholang) and then executed on the Rho Virtual Machine on a number of native platforms.

Smart Contracts include some essential system contracts as well as those providing capabilities for tokens and application-supplied contracts.

A metered and monetized content delivery network (CDN) is enabled through token and micro-payment contracts, accessing a mix of blockchain and off-chain data.

The Attention & Reputation Economy provides a model and set of interactions for motivating respectful and economic creation and dissemination of information within social networks.

In the architecture, there will be several APIs, especially at the top layers. Typed APIs will provide access to the RhoVM, Contract Services, and individual contracts. In addition other APIs (including RESTful APIs) will be provided for accessing the CDN, and the Attention & Reputation Economy.

We'll detail these components in the sections below, from the bottom-up. But first, let’s discuss the requirements and software architecture approach motivating this platform solution.
