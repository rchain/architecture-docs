.. RChain Architecture documentation master file, created by
   sphinx-quickstart on Fri Dec 23 09:00:37 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

###############################################
RChain Platform Architecture
###############################################

:Authors: Ed Eykholt, Lucius Meredith, Joseph Denman
:Date: 1.13.2017
:Organization: RChain Cooperative
:Copyright: This document is licensed under a `Creative Commons Attribution 4.0 International (CC BY 4.0) License`_

.. _Creative Commons Attribution 4.0 International (CC BY 4.0) License: https://creativecommons.org/licenses/by/4.0/


Abstract
===============================================

The RChain platform architecture description provides a high-level blueprint to build a decentralized, economically sustainable public compute infrastructure. While the RChain design is inspired by that of earlier blockchains, it alone realizes decades of research across the fields of concurrent and distributed computation, mathematics, and programming language design. The platform boasts a modular, end-to-end design that commits to correct-by-construction software and industrial extensibility. 

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
   execution_model/rhovm.rst
   execution_model/storage_and_query.rst
   execution_model/consensus_protocol.rst
   execution_model/applications.rst
   references.rst
