#######################################
Motivation
#######################################

The decentralization movement is ambitious and will provide awesome opportunities for new social and economic interactions. Decentralization also provides a counterbalance to abuses and corruption that occasionally occur in large organizations where power is concentrated. Decentralization supports self-determination and the rights of individuals to self-organize. Of course, the realities of a more decentralized world will also have its challenges and issues, such as how the needs of international law, public good, and compassion will be honored.

We admire and respect the awesome innovations of the current Bitcoin, Ethereum, and other platforms that have dramatically advanced the state of decentralized systems and ushered in this new age of cryptocurrency and smart contracts. However, we also see symptoms that those projects did not use the best engineering and mathematical models for scaling and correctness in order to support mission-critical solutions. The ongoing debates about Bitcoin scaling and the June 2016 issues with The DAO smart contract on Ethereum are symptomatic of foundational architectural issues. As one example question: Is it scalable to insist on an explicit serialized processing for all Bitcoin transactions conducted on planet earth?

To become a blockchain solution with industrial-scale utility, RChain must provide content delivery at the scale of Facebook and support transactions at the speed of Visa. After due diligence on the current state of many blockchain projects, after deep collaboration with Ethereum developers, and after understanding their respective roadmaps, we concluded that the current and near-term Blockchain architectures cannot meet these requirements. In mid-2016, we (with Synereo Ltd. at the time) resolved to build a better blockchain architecture.

We began by admitting the following minimal requirements:

* Dynamic, responsive, and provably correct smart contracts.

* Concurrent execution of independent smart contracts.

* Data separation to reduce unnecessary data replication of otherwise independent tokens and smart contracts.

* Dynamic and responsive node-to-node communication.

* Computationally non-intensive consensus/validation protocol.

Approach
==================================================================

Building quality software is challenging. It is easier to build clever software; however, the resulting software is often of poor quality, riddled with bugs, difficult to maintain, and difficult to evolve. Inheriting and working on such software can be hellish for development teams. When building an open-source system to support a mission-critical economy, we reject a minimal-success mindset in favor of end-to-end correctness. 

Therefore, to accomplish the requirements given above, our design approach is committed to:

* A computational model that assumes fine grained concurrency and dynamic network topology.

* A composable and dynamic resource addressing scheme.

* The functional programming paradigm as it more naturally accommodates distributed and parallel processing.

* Formally verified, correct-by-construction protocols which leverage model checking and theorem proving.

* The principles of intension and compositionality.

Together with the blockchain industry, we are still at the dawn of this decentralized movement. Now is the time to lay down a solid architectural foundation. The journey ahead for those who share this ambitious vision is as challenging as it is worthwhile, and this document summarizes that vision and how we seek to accomplish it.
