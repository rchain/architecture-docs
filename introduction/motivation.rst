#######################################
Motivation
#######################################

The decentralization movement is ambitious and will provide awesome opportunities for new social and economic interactions. Decentralization also provides a counterbalance to abuses and corruption that occasionally occur in large organizations where power is concentrated. Decentralization supports self-determination and the rights of individuals to self-organize. Of course, the realities of a more decentralized world will also have their challenges and issues, such as how the needs of international law, public good, and compassion will be honored.

We admire the awesome innovations of Bitcoin, Ethereum, and other platforms that have dramatically advanced the state of decentralized systems and ushered in this new age of cryptocurrency and smart contracts. However, we also see symptoms that those projects did not use the best engineering and formal models for scaling and correctness in order to support mission-critical solutions. The ongoing debates about scaling and reliability are symptomatic of foundational architectural issues. For example, is it a scalable design to insist on an explicit serialized processing order for all of a blockchain's transactions conducted on planet earth?

To become a blockchain solution with industrial-scale utility, RChain must provide content delivery at the scale of Facebook and support transactions at the speed of Visa. After due diligence on the current state of many blockchain projects, after deep collaboration with other blockchain developers, and after understanding their respective roadmaps, we concluded that the current and near-term Blockchain architectures cannot meet these requirements. In mid-2016, we resolved to build a better blockchain architecture.

Together with the blockchain industry, we are still at the dawn of this decentralized movement. Now is the time to lay down a solid architectural foundation. The journey ahead for those who share this ambitious vision is as challenging as it is worthwhile, and this document summarizes that vision and how we seek to accomplish it.

#######################################
Approach
#######################################
We began by admitting the following minimal requirements:

* Dynamic, responsive, and provably correct smart contracts

* Concurrent execution of independent smart contracts

* Data separation to reduce unnecessary data replication of otherwise independent tokens and smart contracts

* Dynamic and responsive node-to-node communication

* Computationally non-intensive consensus/validation protocol

Building quality software is challenging. It is easier to build "clever" software; however, the resulting software is often of poor quality, riddled with bugs, difficult to maintain, and difficult to evolve. Inheriting and working on such software can be hellish for development teams, not to mention their customers. When building an open-source system to support a mission-critical economy, we reject a minimal-success mindset in favor of end-to-end correctness. 

To accomplish the requirements above, our design approach is committed to:

* A computational model that assumes fine-grained concurrency and dynamic network topology;

* A composable and dynamic resource addressing scheme;

* The functional programming paradigm, as it more naturally accommodates distributed and parallel processing;

* Formally verified, correct-by-construction protocols which leverage model checking and theorem proving;

* The principles of intension and compositionality.
