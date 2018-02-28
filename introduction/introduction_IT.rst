##########################################
Introduzione
##########################################

Il progetto RChain open source sta costruendo un'infrastruttura di calcolo pubblico *decentralizzata, economica, resistente alla censura e di blockchain*. Ospiterà ed eseguirà programmi popolarmente definiti "contratti intelligenti".
Sarà affidabile, scalabile, concorrente, con consenso di prova della posta e consegna dei contenuti.

Usando contratti intelligenti, una vasta gamma di applicazioni decentralizzate (dApps) completamente scalabili può essere costruita sopra a questa piattaforma. Le dApp possono trattare aree come identità, token, timestamping, servizi finanziari, consegna di contenuti monetizzati, organizzazioni autonome decentralizzate (DAO), scambi, reputazione, reti sociali private, mercati e molto altro.


.. figure:: ../img/architecture-overview.png
   :align: center
   :width: 1135
   :scale: 50

   Figura: Architettura RChain di alto livello

La rete RChain implementa la comunicazione diretta da nodo a nodo, sopra la quale ogni nodo esegue la piattaforma RChain e un insieme di dApp. 

Il cuore di un RChain è l’Execution Environment della Virtual Machine Rho (RhoVM), che esegue più  RhoVM che stanno eseguendo ciascuna un contratto intelligente. Questi eseguono contemporaneamente e sono multi-thread. 

Questa concorrenza, che è progettata intorno ai modelli formali dei calcoli di processi mobili, insieme a un'applicazione di namespace composizionali, consente ciò che sono in effetti *più blockchain per nodo*. Queste istanze di macchine virtuali a catena multipla e in esecuzione indipendente sono in netto contrasto con un progetto di “calcolo globale” che vincola le transazioni ad essere eseguite in sequenza, su una singola macchina virtuale.
Inoltre, ogni nodo può essere configurato per sottoscrivere ed elaborare i namespace (blockchain) a cui è interessato. 

Come altri blockchain, il raggiungimento del consenso attraverso i nodi sullo stato della blockchain è essenziale. Il protocollo di RChain per la replica e il consenso si chiama Casper ed è un protocollo di prova della posta. 
Simile a Ethereum, un contratto inizia in uno stato, molti nodi ricevono una transazione firmata e quindi le loro istanze di RhoVM eseguono quel contratto al suo stato successivo.
Una serie di operatori nodo, o "validatori vincolati" applicano l'algoritmo di consenso per verificare in modo crittografico-economico che l'intera cronologia delle configurazioni di stato e delle transizioni di stato, dell'istanza RhoVM, siano accuratamente replicate in un archivio dati distribuito.

I contratti blockchain (ovvero contratti, processi o programmi intelligenti), inclusi i contratti di sistema compresi nell'installazione, sono scritti nel linguaggio generale RChain “**Rholang**” (linguaggio riflettente di ordine superiore). Derivato dal formalismo computazionale del rho-calcolus, Rholang supporta la concorrenza programmatica interna. Esprime formalmente la comunicazione e il coordinamento di molti processi eseguiti in composizione parallela. Rholang supporta naturalmente le tendenze del settore in materia di mobilità del codice, API reattive/monadiche, parallelismo, asincronismo e tipi comportamentali.
 
Poiché i nodi sono internamente concorrenti e non è necessario che ognuno esegua tutti i namespace (blockchain), il sistema sarà *scalabile*.

Poiché il linguaggio del contratto e la sua VM sono costruiti secondo le specifiche formali della matematica dimostrabile, e dal momento che la pipeline del compilatore e l'approccio ingegneristico sono *corretti per costruzione*, ci aspettiamo che la piattaforma sia considerata *affidabile*.
