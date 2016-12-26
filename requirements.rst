.. _requirements:

################################################################################
Requirements
################################################################################

Let’s look at the requirements for the platform from the vantage point of the
developers building applications on top of it. Then, let’s look at what is
required of the platform itself in order to achieve those requirements.

**Requirements for Decentralized Application Developers**

* Fully decentralized
* Tamper-proof blockchain for “immutable” history
* Smart contract state (conserved quantities and VM state) reliably replicated
* Support for multiple tokens
* Ability to write predictably secure software contracts
* Scalable

**Requirements of the Architecture**

* Design with provably correct approaches
* Data separation using namespace addressing to reduce unnecessary data replication of otherwise independent tokens and contracts
* Support for concurrent protocol execution
* Distributed and decentralized
* Minimal external dependencies
* Peer-to-peer and discoverable nodes
* Consensus protocol that is computationally efficient and not resource-intensive

**Non-Requirements**

* There is a long list of items the architecture will not address, but let’s list a few to dispel what might otherwise be common misperceptions. For example, the architecture will not address:
* Compatibility with smart contracts or scripts written on other blockchain technologies
* Automated coin conversion within the platform, since this can be better handled at the application level
