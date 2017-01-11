.. _contract-design:

################################################################################
CONTRACT DESIGN
################################################################################

An RChain contract is a well-specified, well-behaved, and formally verified program that interacts with other well-specified, well-behaved, and formally verified programs.

In this section on contract design, we cover contract interaction through the production of Rholang. To begin, we give an overview of contract interaction on the RChain platform. Afterwards, we describe the core formalism RChain uses to achieve formal verification and to model concurrency on many of RChain’s system layers. Then, we explore how that core model extends to accomodate best-in-industry surface-language standards such as reflection, parallelism, asynchronicity, reactive data streams, and compile-time security-type checks. Finally, we give an application for a nested and composable resource addressing structure to partition transactional environments across RChain.
