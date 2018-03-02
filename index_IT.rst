.. File master della documentazione sull’architettura Rchain, creato da
   sphinx-quickstart Ven 23 Dic 09:00:37 2016.
   Puoi adattare questo file completamente a tuo piacimento, ma almeno dovrebbe
   contiene la direttiva di root `toctree`.

###############################################
Architettura della piattaforma Rchain
###############################################

:Autori: Ed Eykholt, Lucius Meredith, Joseph Denman
:Data: 2017-07-22
:Organizzazione: Cooperativa RChain
:Copyright: This document is licensed under a `Licenza Creative Commons Attribution 4.0 International (CC BY 4.0)`_

.. _Licenza Creative Commons Attribution 4.0 International (CC BY 4.0): https://creativecommons.org/licenses/by/4.0/


Estratto
===============================================

La descrizione dell'architettura della piattaforma Rchain fornisce un progetto di alto livello dell'infrastruttura di calcolo pubblico decentralizzata ed economicamente sostenibile di Rchain. Sebbene il design di Rchain sia ispirato a quello dei precedenti blockchain, realizza anche decenni di ricerche nei campi della computazione concorrente e distribuita, della matematica e della progettazione del linguaggio di programmazione. La piattaforma include un design modulare, end-to-end che si impegna a correggere il software di costruzione e l'estensibilità industriale. 

**Destinatari:** Questo documento è destinato agli sviluppatori di software e agli innovatori interessati ai sistemi decentralizzati.

.. toctree::
   :maxdepth: 2
   :caption: Contenuto:

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
