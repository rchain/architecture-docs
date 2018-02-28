.. _consensus_protocol:

**************************************************************
Algoritmo di consenso di Casper
**************************************************************
I nodi che assumono il ruolo di validazione hanno la funzione di raggiungere il consenso sullo stato del blockchain. I validatori assicurano inoltre che una blockchain sia auto-consistente e non sia stata manomessa e che sia protetta contro l'attacco Sybil.

Il protocollo di consenso di Casper comprende i cicli di bonding, unbonding e scommesse basati sulle puntate che determinano il consenso. Lo scopo di un protocollo di consenso decentralizzato è assicurare la coerenza di blockchain o blockchain parziali (basati su namespace), su più nodi. Per raggiungere questo obiettivo qualsiasi protocollo di consenso deve produrre un risultato che sia una dimostrazione delle proprietà di sicurezza e di terminazione della classe di protocolli di consenso, in un'ampia classe di guasti e condizioni di rete.

Il protocollo di consenso di RChain utilizza le scommesse basate sulle puntate, in modo simile al progetto Casper di Ethereum. Questo è chiamato un protocollo a “dimostrazione della puntata” da parte della più ampia comunità di blockchain, ma tale etichetta porta ad alcune errate percezioni, compresi rischi di centralizzazione esagerati. I validatori sono legati a una puntata, che è un deposito cauzionale inserito in un contratto di deposito a garanzia. A differenza delle scommesse di Ethereum su interi blocchi, le scommesse di RChain si basano su proposte logiche. Una proposta è un insieme di affermazioni sulla blockchain, ad esempio: quali transazioni (ossia le transizioni di stato proposte) devono essere incluse, in quale ordine, quali transazioni non devono essere incluse o altre proprietà. Un esempio concreto di una proposta è: “transaction t should occur before transaction s” and “tla transazione r non deve essere inclusa”. Per ulteriori informazioni, consultare la bozza delle specifiche `Logica per le scommesse sulle proposte (v0.7)`_.

.. _Logica per le scommesse sulle proposte (v0.7): https://docs.google.com/document/d/1x0-fUU1dK9CT79GUqYUOoejfqY3bNckDcXgIbBTkfkc/edit#heading=h.jzluq1kbohwq

In certi punti di rendezvous i validatori calcolano un sottoinsieme di proposte massimamente coerente. In alcuni casi, questo può essere molto complicato dal punto di vista computazionale e può richiedere molto tempo. A causa di ciò, esisterà un time-out che, se raggiunto, spinge i validatori a presentare proposte più piccole. Una volta che vi è consenso tra i validatori sul sottoinsieme di proposte massimamente coerente, il blocco successivo può essere facilmente materializzato trovando un modello minimale in base al quale le proposte sono valide. A causa di questa progettazione e dell'isolamento transazionale per namespace, la maggior parte dei blocchi può essere sintetizzata in parallelo.

Passiamo attraverso la sequenza tipica:

1. Un validatore è un ruolo del nodo. Ogni validatore mette su una puntata, che è simile a un legame, al fine di assicurare agli altri validatori che saranno dei buoni attori. La posta è a rischio se non fossero buoni attori.
2. I client inviano richieste di transazione ai validatori.
3. I validatori riceventi quindi creano una proposta che include una transazione recente.

*Nota: il consenso viene eseguito solo quando la cronologia delle transazioni non è coerente tra i nodi*

4. Ci sono serie di cicli di scommesse tra i nodi:

    a. Il validatore di origine prepara una scommessa, che include quanto segue:
    
      - *source* = l'origine della scommessa
      - *target* = la destinazione o il target della scommessa
      - *claim* = la richiesta della scommessa. Questo è un blocco, una proposta o un sottoinsieme massimamente coerente di proposte
      - *belief* = la fiducia del giocatore nella richiesta data l'evidenza nella giustificazione. Questa è una denotazione della strategia di scommessa usata dal validatore.
      - giustificazione. Questa è la dimostrazione del perché è una scommessa ragionevole.
      
    b. Il validatore piazza la scommessa.
    
    c. Il validatore ricevente valuta la scommessa. Nota, queste strutture di giustificazione possono essere utilizzate per determinare varie proprietà della rete. Ad esempio, un algoritmo può rilevare equivoci o creare un grafico di giustificazione o rilevare quando troppe informazioni sono presenti nella scommessa. Nota come vengono considerati i vettori di attacco e come la disciplina della teoria dei giochi è stata applicata alla progettazione del protocollo.
    
5. I cicli di scommesse continuano a lavorare verso una dimostrazione. Nota:

    d. L'obiettivo del ciclo di scommesse è che i nodi del validatore raggiungano il consenso su un insieme di proposte massimamente coerente.
    e. Una condizione preliminare per la dimostrazione è che ⅔ dei validatori si stiano comportando in modo ragionevole. 
    f. Alla fine il ciclo di scommesse dovrà convergere e convergerà.
    g. L'elaborazione è parzialmente sincrona durante la convergenza.
    h. Con le scommesse per proposta, la progettazione sarà in grado di sintetizzare pezzi molto più grandi della blockchain in una sola volta. I cicli possono convergere rapidamente quando non ci sono conflitti. Il punto centrale dell'approccio per proposta è che molti blocchi possono essere materializzati tutti in una volta. Questa proposta raggiunge i limiti della dimensione del blocco. Non ci sono discussioni a riguardo perché l'insieme massimo di proposte può consentire a centinaia o persino a migliaia di blocchi di concordare contemporaneamente. Questo creerà un enorme vantaggio di velocità rispetto ai blockchain esistenti.
    i. Per ogni ciclo di scommesse, un determinato nodo di validazione può vincere o perdere il proprio importo della scommessa.
    
6. La scalabilità è ottenuta attraverso una partizione fine-grained delle proposte e tramite la nidificazione (ricorsione) del protocollo di consenso.
I blocchi sono sintetizzati dal protocollo quando vi è accordo sull'insieme di proposte massimamente coerenti, e questo si verifica quando c'è una dimostrazione di convergenza tra le scommesse. Il ciclo di scommesse corrente poi crolla.

Per ulteriori informazioni, consultare:

* `Consensus Games`_: Un framework assiomatico per l'analisi e il confronto di un'ampia gamma di protocolli di consenso.
* Per maggiori dettagli sul protocollo di consenso di RChain, si veda `Logica per le scommesse -- Scommesse sulle proposte`_. 
* Per saperne di più su Casper di Ethereum e per discussioni su `Ethereum Research Gitter`_ e `Reddit/ethereum`_.
* La matematica alla base del ciclo di scommesse è un Iterated Function System. La convergenza corrisponde ad avere attrattori (punti fissi) all’IFS. Con questo, possiamo dimostrare cose sulla convergenza con premi e punizioni. Possiamo dare la massima libertà al validatore-nodo-scommettitori. Gli unici che sono rimasti in piedi sono validatori che sono coinvolti nel comportamento delle scommesse convergenti.

.. _Consensus Games: https://github.com/leithaus/pi4u/blob/master/cg/cg.pdf
.. _Logica per le scommesse -- Scommesse sulle proposte: https://docs.google.com/document/d/1ZHaCXMlDZv-okGcRJ6P4-zWdqVDJSe-9bvEZe9jwpig/edit
.. _Ethereum Research Gitter: https://gitter.im/ethereum/research
.. _Reddit/ethereum: https://www.reddit.com/r/ethereum
