#######################################
Motivazione
#######################################

Il movimento di decentralizzazione è ambizioso e offrirà grandi opportunità per nuove interazioni sociali ed economiche. Il decentramento fornisce anche un contrappeso agli abusi e alla corruzione che si verificano occasionalmente nelle grandi organizzazioni in cui il potere è concentrato. Il decentramento supporta l'autodeterminazione e il diritto delle persone ad auto-organizzarsi. Certamente, le realtà di un mondo più decentralizzato avranno anche le loro sfide e questioni, come ad esempio il modo in cui le necessità del diritto internazionale, del bene pubblico e della compassione saranno onorati.

Ammiriamo le straordinarie innovazioni di Bitcoin, Ethereum e delle altre piattaforme che hanno notevolmente migliorato lo stato dei sistemi decentralizzati e inaugurato questa nuova era di criptovaluta e contratti intelligenti. Tuttavia, vediamo anche i sintomi del fatto che quei progetti non utilizzavano i migliori modelli formali e di ingegneria per il ridimensionamento e la correttezza al fine di supportare soluzioni mission-critical. I dibattiti in corso su ridimensionamento e affidabilità sono sintomatici di problemi architettonici fondamentali. Ad esempio, è un progetto scalabile insistere su un ordine di elaborazione serializzato esplicito per tutte le transazioni di blockchain condotte sul pianeta terra?

Per diventare una soluzione blockchain con utility su scala industriale, BCot deve fornire la consegna dei contenuti alla scala di Facebook e supportare le transazioni alla velocità di Visa. Dopo la dovuta diligenza sullo stato attuale di molti progetti blockchain, dopo una profonda collaborazione con altri sviluppatori blockchain, e dopo aver compreso le rispettive tabelle di marcia, abbiamo concluso che le architetture blockchain attuali a breve termine non possono soddisfare questi requisiti. A metà del 2016, abbiamo deciso di costruire una migliore architettura blockchain.

Insieme al settore blockchain, siamo ancora agli albori di questo movimento decentralizzato. Ora è il momento di stabilire una solida base architettonica. Il viaggio in avanti per coloro che condividono questa visione ambiziosa è tanto impegnativo quanto utile, e questo documento riassume quella visione e il modo in cui cerchiamo di realizzarla.

#######################################
Approccio
#######################################
Abbiamo iniziato ammettendo i seguenti requisiti minimi:

* Contratti intelligenti dinamici, reattivi e provatamente corretti.

* Esecuzione concorrente di contratti intelligenti indipendenti.

* Separazione dei dati per ridurre la riproduzione non necessaria dei dati di token e contratti intelligenti altrimenti indipendenti.

* Comunicazione dinamica e reattiva da nodo a nodo.

* Protocollo di consenso/convalida computazionalmente non intensivo.

Costruire software di qualità è impegnativo. È più facile creare un software "intelligente"; tuttavia, il software risultante è spesso di scarsa qualità, pieno di bug, difficile da mantenere e difficile da evolvere. Ereditare e lavorare su tale software può essere fatale per i team di sviluppo, per non parlare dei loro clienti. Quando costruiamo un sistema open source per supportare un'economia mission-critical, rifiutiamo una mentalità di successo minimo a favore della correttezza end-to-end. 

Per soddisfare i requisiti di cui sopra, il nostro approccio progettuale si impegna per:

* Un modello di calcolo che presuppone una concorrenza fine-grained e una topologia di rete dinamica.

* Uno schema di indirizzamento delle risorse componibile e dinamico.

* Il paradigma di programmazione funzionale, in quanto più naturalmente accoglie l'elaborazione distribuita e parallela.

* Protocolli verificati formalmente e costruiti correttamente che sfruttano il model checking e la dimostrazione di teoremi.

* I principi di intensione e composizionalità.
