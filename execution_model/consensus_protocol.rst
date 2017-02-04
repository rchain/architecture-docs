.. _consensus_protocol:

**************************************************************
Validation and Casper Consensus Protocol
**************************************************************
Nodes that take on the validation role have the function to achieve consensus on the blockchain state. Validators also assure a blockchain is self-consistent and hasn’t been tampered with and protect against Sybil attack.

The Casper consensus protocol includes stake-based bonding, unbonding, and betting cycles that result in consensus. The purpose of a decentralized consensus protocol is to assure consistency of blockchains or partial blockchains (based on shards), across multiple nodes. To achieve this any consensus protocol should produce an outcome that is a proof of the safety and termination properties of class of consensus protocols, under a wide class of fault and network conditions. 

RChain’s consensus protocol uses stake-based betting, similar to Ethereum’s Casper design. This is called a “proof-of-stake” protocol by the broader blockchain community, but that label leads to some misperceptions including overstated centralization risks. Validators are bonded with a stake, which is a security deposit placed in an escrow-like contract. Unlike Ethereum’s betting on a whole blocks, RChain’s betting is on logical propositions. A proposition is a set of statements about the blockchain, for example: which transactions (i.e. proposed state transitions) must be included, in which order, which transactions should not be included, or other properties. A concrete example of a proposition is: “transaction t should occur before transaction s” and “transaction r should not be included”. For more information, see the draft specification Logic for Betting on Propositions (v0.7).

At certain rendezvous points validators compute a maximally consistent subset of propositions. In some cases, this can be computationally hard and take a long time. Because of this a time-out will exist, which, if reached forces validators to submit smaller propositions. Once there is consensus among the validators on the maximally consistent subset of propositions, the next block can easily be materialized by finding a minimal model under which the propositions are valid. 
Because of this design and because of the concurrency enabled by sharding of the address space, consensus can be reached for a huge number of transactions at a time.
Let’s walk through the typical sequence:

A validator is a node role. Validators each put up a stake, which is akin to a bond, in order to assure the other validators that they will be good actors. The stake is at risk if they aren’t a good actor.
Clients send transaction requests to validators.
Receiving validators then create a proposition including a recent transaction. 
There are sets of betting cycles among nodes:
The originating validator prepares a bet, which includes the following:
- source = the origin of the bet
- target = the destination or target for the bet
- claim = the claim of the bet. This is a block, a proposition, or maximally consistent subset of propositions
- belief = the player’s confidence in the claim given the evidence in the justification. This is a denotation of the betting strategy used by the validator.
- justification. This is evidence for why it is a reasonable bet.
The validator places the bet.
The receiving validator evaluates the bet. Note, these justification structures can be used to determine various properties of the network. For example, an algorithm can detect equivocation, or create a justification graph, or detect when too much information is in the bet. Note how attack vectors are considered, and how game theory discipline has been applied to the protocol design.
The betting cycles continue working toward a proof. Note:
The goal of the betting cycle is for the validator nodes to reach consensus on a maximally consistent set of propositions.
A prerequisite condition for the proof is that ⅔ of the validators are behaving in a reasonable fashion. 
Eventually the betting cycle will and must converge.
The processing is partially synchronous during convergence.
With by-proposition betting, the design will be able to synthesize much bigger chunks of the blockchain all at once.
Cycles can converge quickly when there are no conflicts. 
The point of the by-proposition approach is that several blocks can be materialized all at once. This proposal gets around block size limits. There's no argument about it because the maximal consistent set of propositions might allow for hundreds or even thousands of blocks to be agreed all at once. This will create a huge speed advantage over existing blockchains.
For each betting cycle a given validator node may win or lose their bet amount.
Scalability is achieved via a fine-grained sharding of proposals and via nesting (recursion) of the consensus protocol.
Blocks are synthesized by the protocol when there is agreement on the set of maximally-consistent propositions, and this occurs when there is a proof of convergence among the bets. The current betting cycle then collapses.

For additional information, see:
Consensus Games: An Axiomatic Framework for Analyzing and Comparing a Wide Range of Consensus Protocols.
For more detail on RChain’s consensus protocol, see Logic for Betting -- On betting on propositions 
To find out more about Ethereum’s Casper and discussions in the Ethereum Research Gitter and Reddit/ethereum.
The math underlying the betting cycle is an Iterated Function System. Convergence corresponds to having attractors (fix-points) to IFS. With this, we can prove things about convergence with awards and punishments. We can give validator-node-betters maximum freedom. The only ones that are left standing are validators that are engaged in convergent betting behavior. 
