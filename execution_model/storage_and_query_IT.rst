.. _storage_and_query:

************************************************************
Archiviazione e query
************************************************************

Panoramica
----------------------------------------

Il livello di rete Archiviazione e Query *appare* a ciascun nodo come un database locale ad accesso asincrono con spazio di archiviazione noleggiato. Dietro le quinte, tuttavia, il livello di Archiviazione e Query è completamente decentrato e soggetto all'algoritmo di consenso. In accordo con le funzionalità di micro-transazione inerenti alle soluzioni blockchain, gli utenti di dApp su RChain pagano le risorse (calcolo, memoria, archiviazione e rete) utilizzando i token. La progettazione di RChain considera tutti gli archivi “conservati”, sebbene non tutti i dati vengano conservati per sempre. Invece, l'archiviazione dei dati sarà noleggiata e costerà ai produttori di tali dati in proporzione alle dimensioni, alla loro complessità e alla durata del noleggio. I consumatori possono anche essere tenuti a pagare per accedere al loro recupero. I produttori di dati e i consumatori pagano indirettamente gli operatori dei nodi.

La semplice ragione economica che giustifica il noleggio è che lo stoccaggio deve essere pagato da qualcuno; altrimenti non può essere archiviato in modo affidabile o “per sempre”. Abbiamo scelto di rendere diretto il meccanismo economico. È un'idea ambientalmente ostile che lo stoccaggio sia reso "libero" solo per sovvenzionarlo con un processo non correlato. Una piccola parte del costo reale è misurabile nelle tracce dei centri dati che stanno crescendo fino a dimensioni sbalorditive. Questo addebito per i dati a cui si accede aiuta anche a ridurre l'archiviazione "di attacco", ovvero l'archiviazione di contenuti illegali per screditare la tecnologia.

È supportata una varietà di dati, tra cui json pubblico non crittografato, BLOB crittografati o un mix. Questi dati possono anche essere semplici puntatori o hash di contenuto che fanno riferimento a dati fuori piattaforma memorizzati in posizioni e formati privati, pubblici o del consorzio.

Semantica dei dati
----------------------------------------

La blockchain RChain memorizzerà lo stato, la cronologia delle transazioni locali e le relative prosecuzioni di un contratto. Come Ethereum, la blockchain di RChain implementerà anche la semantica transazionale crittograficamente verificabile per creare una storia temporale lineare della computazione eseguita sulla piattaforma. Si noti che la matematica alla base di questa struttura semantica di blockchain è nota come una categoria monoidale tracciata. Per maggiori dettagli si veda il documento di Masahito Hasegawa su questo argomento, `Ricorsione dalla condivisione ciclica: categorie mononucleate tracciate e modelli di Lambda Calculi ciclico`_.

.. _Ricorsione dalla condivisione ciclica: categorie mononucleate tracciate e modelli di Lambda Calculi ciclico: http://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.52.31&rep=rep1&type=pdf

============================================
Livello di accesso ai dati e lingua specifica del dominio
============================================

SpecialK è il DSL per l'accesso ai dati, mentre KVDB è una struttura di dati a memoria distribuita dietro la DSL. SpecialK definisce i modelli di accesso ai dati distribuiti in modo coerente, come mostrato di seguito:

.. table:: Figura - Schema di accesso ai dati di SpecialK

+---------------------------+-----------------------------------------------------+-----------------------------+-----------------------------------+--------------------------------------+
|                           | **Lettura e scrittura a livello di oggetto (blocco distribuito)** | **Database lettura e scrittura** | **Messaggi di pubblicazione / sottoscrizione** | **Pubblica / Iscriviti con cronologia** |
+===========================+=====================================================+=============================+===================================+======================================+
| **Dati**                  | Effimero                                           | Persistente                  | Effimero                         | Persistente                           |
+---------------------------+-----------------------------------------------------+-----------------------------+-----------------------------------+--------------------------------------+
| **Continuazione(K)** [#]_  | Effimero                                           | Effimero                   | Persistente                        | Persistente                           |
+---------------------------+-----------------------------------------------------+-----------------------------+-----------------------------------+--------------------------------------+
| **Verbo del produttore** [#]_    | Inserisci                                                 | Archivia                       | Pubblica                           | Pubblica con storia                 |
+---------------------------+-----------------------------------------------------+-----------------------------+-----------------------------------+--------------------------------------+
| **Verbo del consumatore**         | Ottieni                                                 | Leggi                        | Iscriviti                         | Iscriviti                            |
+---------------------------+-----------------------------------------------------+-----------------------------+-----------------------------------+--------------------------------------+


*Figura - Pattern di accesso ai dati di SpecialK*

Dal punto di vista dello SpecialK DSL e API, quando si esegue un'azione di accesso ai dati, come il verbo Get/Ottieni (con uno schema), è indifferente che i dati siano memorizzati localmente o remotamente, cioè su qualche altra rete nodo. C'è indipendentemente un meccanismo di query singolo.

L’insieme tecnologico SpecialK 2016 e precedenti (Agent Services, SpecialK e KVDB, con RabbitMQ e MongoDB) ha distribuito una Content Delivery Network decentralizzata, sebbene non fosse né misurata né monetizzata. I componenti SpecialK e KVDB si trovano sopra MongoDB e un protocollo avanzato di Accodamento messaggi (ZeroMQ è in fase di esplorazione) per creare la logica decentralizzata per l'archiviazione e il recupero dei contenuti, sia a livello locale che remoto. Le attuali implementazioni 1.0 di SpecialK e KVDB sono scritte in Scala e sono in `GitHub`_.

.. _GitHub: https://github.com/leithaus/SpecialK

La semantica delle query varia a seconda di quale livello nell'architettura viene coinvolto. A livello SpecialK, le chiavi sono espressioni prolog, che vengono successivamente interrogate tramite espressioni datalog. Più in alto nell'architettura, le espressioni prolog delle etichette vengono utilizzate per l’archiviazione e le espressioni datalog delle etichette vengono utilizzate per le query. In RChain, gli strati SpecialK e KVDB saranno reimplementati in Rholang (rispetto alla precedente implementazione in Scala, con implementazione personalizzata di continuazioni delimitate e serializzazione del codice).

Per ulteriori informazioni, consultare `SpecialK & KVDB`_ – Un linguaggio di schemi per il Web.

.. _SpecialK & KVDB: https://docs.google.com/document/d/1aM5OIJWOyW89rHdUg6d9-YVbItdtxxiosP_fXZQaRdg/edit

=====================================================
KVDB - Accesso ai dati, continuazione, cache
=====================================================

I dati saranno accessibili usando la semantica SpecialK, mentre sono fisicamente archiviati in un database decentralizzato di valori-chiave noto come "KVDB". Di seguito viene mostrata una vista di come due nodi collaborano per rispondere a una richiesta di get/ottieni:


.. figure:: ../img/specialk.png
  :align: center
  :width: 3446
  :scale: 25
  
  *Figura - Accesso ai dati decentralizzati in SpecialK*
  

1) Il nodo prima interroga la cache della sua memoria per i dati richiesti. Quindi se non li trova,

2) interroga il suo negozio locale e, se non vengono trovate, memorizza una continuazione delimitata in quella posizione, e

3) interroga la rete. Se e quando la rete restituisce i dati appropriati, la continuazione delimitata viene riportata nel campo di applicazione con i dati recuperati come parametro.

Perché RChain non ha selezionato IPFS (InterPlanetary File System) per la memoria distribuita? Oltre a portare rischi di centralizzazione, IPFS utilizza un percorso per raggiungere il contenuto, mentre SpecialK utilizza interi alberi (e alberi con buchi) per arrivare al contenuto. IPFS ha un modello di percorso intuitivo, ma la sua progettazione pone la domanda su come fare le query. SpecialK è iniziato dal lato dell'indirizzamento delle query. Ora, il progetto RChain può trarre beneficio dal lavoro IPFS, incluso il suo hashing per l'indirizzamento del contenuto, una volta che la semantica della query di SpecialK viene messa a punto. SpecialK può anche utilizzare una chiave piatta generata casualmente che non ha alcuna correlazione con i dati.

Comunicazioni sui nodi P2P
---------------------------------------------

La semantica di storage decentralizzata di SpecialK necessita di un'infrastruttura di comunicazione di nodi. Analogamente ad altre implementazioni decentralizzate, il componente di comunicazione P2P gestisce il rilevamento del nodo, l’affidabilità inter-nodo e la comunicazione. L'implementazione corrente utilizza RabbitMQ, sebbene ZeroMQ venga considerato.

.. [#] Si noti che per convenzione una funzione di continuazione è rappresentata come un parametro chiamato k.
.. [#] Questo è solo un sottoinsieme dei verbi possibili in questa scomposizione della funzionalità. Il verbo recuperare, ad esempio, ottiene i dati senza lasciare una continuazione, se non ci sono dati disponibili.
