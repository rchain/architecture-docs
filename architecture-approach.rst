.. _architecture-approach:

################################################################################
Architectural Approach
################################################################################

Building quality software is challenging. It is easier to hand-craft clever software;
however, the resulting software is often of poor quality, riddled with bugs,
difficult to maintain, and difficult to evolve. Inheriting and working on such software
can be hellish for development teams. When building an open-source system to support a
mission-critical economy, we reject a minimal-success mindset in favor of end-to-end
correctness.

Therefore, we resolved to meet the requirements stated in the earlier section, and to:

* Build quality software that implements well-specified protocols.
* Build software based on software architecture patterns and other correct-by-construction approaches.
* Take cues from mathematics. Use formal verification of protocols, leveraging model checking and theorem proving.
* Make evidence-based decisions with supporting rationale for design decisions.
* Choose functional programming paradigm, since it better enables distributed and parallel processing.
* Apply best practices of software patterns, including compositionality.

