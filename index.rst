.. RChain Architecture documentation master file, created by
   sphinx-quickstart on Fri Dec 23 09:00:37 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

###############################################
RChain Platform Architecture Vision
###############################################

:Authors: Ed Eykholt, Lucius Meredith, Joseph Denman
:Date: 2017-07-22
:Organization: RChain Cooperative
:Copyright: This document is licensed under a `Creative Commons Attribution 4.0 International (CC BY 4.0) License`_

.. _Creative Commons Attribution 4.0 International (CC BY 4.0) License: https://creativecommons.org/licenses/by/4.0/


Abstract
===============================================

The RChain Platform Architecture Vision provides a high-level blueprint of the RChain decentralized, economically sustainable, public compute infrastructure. While the RChain design is inspired by earlier blockchains, it also realizes decades of research across the fields of concurrent and distributed computation, mathematics, and programming language design. The platform includes a modular, end-to-end design that commits to correct-by-construction software and industrial extensibility.


Forward (November 2018)
=================================

Much has changed in the fifteen months since this architecture document first laid out the vision of RChain. At that time `rchain/rchain`__ had only a few dozen commits. There are now over 7,000 commits and the project is approaching its first release.

This revised document maintains the purpose as the original, a high-level blueprint of the RChain Vision. Many of the ideas are already implemented. Others are month or years down the roadmap. And some of the original ideas have been improved over the development cycle.

For details on RChain's current implementation, see `developer.rchain.coop`__ including
 open source github repository, Rholang tutorial, and project status.

 __ https://github.com/rchain/rchain
__ https://developer.rchain.coop/

This document is written for innovators, software developers, and enthusiasts who are interested in bootstrapping coordination at scale through decentralized systems.


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
