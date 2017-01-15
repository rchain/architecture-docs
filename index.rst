.. RChain Architecture documentation master file, created by
   sphinx-quickstart on Fri Dec 23 09:00:37 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

###############################################
RChain Platform Architecture
###############################################

Abstract
===============================================

The RChain platform architecture description provides a high-level blueprint to build a decentralized, economically sustainable public compute infrastructure. While the RChain design is inspired by that of earlier blockchains, it alone realizes decades of research across the fields of concurrent and distributed computation, mathematics, and programming language design. The platform boasts a modular, end-to-end design that commits to correct-by-construction software and industrial extensibility. 

**This document expounds on basic contract interaction beginning at the core computational model of the RChain platform, provides a description of the concurrent blockchain language, "Rholang", and ends with an application for a nested and composable resource addressing structure to partition transactional environments across RChain. It does not explore the Rho Virtual Machine or database and query implemention. Those sections will be added in the weeks following.**

**Intended audience:** This document is written primarily for software designers and
developers who want to help see this vision realized, and for others who want to
support these efforts.

.. toctree::
   :maxdepth: 2
   :caption: Contents:

   introduction/motivation.rst
   introduction/introduction.rst
   introduction/comparison-of-blockchains.rst
   introduction/architecture-overview.rst
   contracts/contract-design.rst
   contracts/namespaces.rst
