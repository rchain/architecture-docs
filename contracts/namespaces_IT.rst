.. _namespaces:

*****************************************************************
Logica del Namespace
*****************************************************************

Perché una soluzione blockchain di scala internet sia realizzabile, essa, come Internet, deve possedere una logica per ragionare sulla “posizione” di una risorsa. In particolare, come si fa riferimento a una risorsa? Come determinare quali agenti possono accedere a tale risorsa in quali condizioni? A differenza di molti altri blockchain, in cui gli indirizzi sono chiavi pubbliche piatte (o loro hash), lo spazio degli indirizzi virtuali di RChain sarà suddiviso in namespace. **Secondo una spiegazione molto generale, un namespace è un insieme di canali nominati.** Poiché i canali sono spesso implementati come archivi di dati, un namespace è equivalentemente a un insieme di risorse controverse.

.. sidebar:: Q & A: Namespace e spesa doppia

   Q: Supponiamo che Alice, Bob e Carol siano ciascuno in namespace 
   distinti e abbiamo due pagamenti: Alice-a-Bob e Alice-a-Carol. Se
   io sono un nodo che vuole solo prendersi cura di Alice, come posso
   sapere che Alice non spende due volte?

   A: Un namespace è solo una raccolta di nomi. Tutti gli indirizzi di
   blockchain sono nomi. Una raccolta può essere descritta in diversi
   modi. Uno di questi è ottenuto estendendo esplicitamente ciascun
   elemento nella collezione. Un altro modo è ottenuto fornendo
   intenzionalmente una regola o un programma che genera la raccolta o
   riconosce quando un articolo è nella collezione o fuori dalla
   collezione. I namespace più interessanti sono quelli
   intenzionalmente specificati.

   Ora, il prossimo passo è quello di metterli in relazione con
   utenti, contratti e nodi. Sia gli utenti che i contratti 
   interagiscono tra loro tramite nomi. I nodi verificano le
   transazioni in determinati namespace e le transazioni sono eventi 
   i/o (che sono usati come canali). Qualsiasi transazione che
   coinvolge due namespace separati deve essere servita da una
   raccolta di nodi che gestisce quei namespace. Se non ci sono nodi
   che gestiscono le transazioni che combinano i namespace, la
   transazione non può accadere.

   Se ci sono nodi che combinano i namespace, allora
   l'algoritmo del consenso garantisce che tutti i nodi concordino
   sulle transazioni. Più specificamente, sono d'accordo sui vincitori
   di ogni competizione. Così, non ci può mai essere una doppia spesa.
   La più grande minaccia è trovare namespace composti serviti da
   pochi validatori. Fortunatamente, puoi vedere il potere del
   validatore dietro un namespace e decidere se fidarti di quel
   namespace.


Abbiamo stabilito che due processi devono condividere un canale nominato per comunicare, ma cosa succede se più processi condividono lo stesso canale? Il non determinismo transazionale è introdotto sotto due condizioni generali che rendono una risorsa controversa e suscettibile alle condizioni della competizione:

::

                                    for(ptrn <- x){P1} | x!(@Q) | for(ptrn <- x){P2} 


La prima condizione di competizione si verifica quando più client in composizione parallela competono per *ricevere* una risorsa dati su un canale con nome. In questo caso :code:`P1` e :code:`P2` , sono in attesa, sul canale nominato :code:`x`,  per la risorsa :code:`@Q` viene inviato su :code:`x` da un altro processo. I client eseguiranno le loro continuazioni se e solo se viene constatato il valore corretto in quella posizione. Negli altri casi in cui molti client sono in concorrenza, possono essere possibili molte riduzioni, ma in questo caso ne può derivare solo una delle due. Una dove :code:`P1` riceve :code:`@Q` prima e uno dove :code:`P2` riceve :code:`@Q` prima, entrambi possono restituire risultati diversi quando :code:`@Q` è sostituito nei rispettivi corpi protocollari.

::

                                          x!(@Q1) | for(ptrn <- x){P} | x!(@Q2)
                                          
                                          
La seconda condizione di competizione si verifica quando due client competono per *inviare* una risorsa dati su un canale denominato. In questo caso, due client sono entrambi in competizione per inviare una risorsa dati :code:`@Q` al client sul canale nominato :code:`x`, ma può verificarsi solo una delle due transazioni - una in cui il client ricevente riceve :code:`@Q1` first and one where it receives :code:`@Q2` prima, entrambi dei quali possono restituire risultati diversi quando vengono sostituiti nel corpo del protocollo di :code:`P`.

Per i protocolli che competono per le risorse, questo livello di non determinismo è inevitabile. Più avanti, nella sezione sul consenso, descriveremo in che modo l'algoritmo di consenso mantiene lo stato replicato convergendo su una delle numerose occorrenze possibili della transazione in un processo non deterministico. Per ora, osserva come la semplice ridefinizione di un nome limiti la riduzione nella prima condizione di competizione:

::

            for(ptrn <- x){P1} | x!(@Q) | for(ptrn <- v){P2} → P1{ @Q/ptrn } | for(ptrn <- v){P2}


--e la seconda condizione di competizione:

::

                        x!(@Q1) | for(ptrn <- x){P} | u!(@Q2) → P{ @Q1/ptrn } | u!(@Q2)
                            
                            
In entrambi i casi, il canale e la risorsa dati comunicata non sono più controversi semplicemente perché ora comunicano su due canali distinti e denominati. In altre parole, si trovano in namespace separati. Inoltre, i nomi sono dimostrabilmente indecifrabili, quindi possono essere acquisiti solo quando li dà un processo esterno discrezionale. Poiché un nome non è percorribile, una risorsa è visibile solo per i processi/contratti che hanno conoscenza di quel nome [5]_. Quindi, insiemi di processi che si eseguono su set non in conflitto di canali denominati, cioè insiemi di transazioni eseguite in namespace separati, possono essere eseguiti in parallelo, come illustrato di seguito:

::

   for(ptrn1 <- x1){P1} | x1!(@Q1) | ... | for(ptrnn <- xn){Pn} | xn!(@Qn) → P1{ @Q1/ptrn1} | ... | Pn{ @Qn/ptrnn }

 | for(ptrn1 <- v1){P1} | v1!(@Q1) | ... | for(ptrnn <- vn){Pn} | vn!(@Q1) → P1{ @Q1/ptrn1} | ... | Pn{ @Qn/ptrnn }


L'insieme di transazioni eseguite in parallelo nel namespace :code:`x`, e l'insieme di transazioni eseguite nel namespace :code:`v`, sono double-blind; sono anonimi tra loro a meno che non siano introdotti da un processo ausiliario. Entrambe le serie di transazioni comunicano la stessa risorsa, :code:`@Q`, e anche richiedendo che :code:`@Q` incontri lo stesso :code:`ptrn`, tuttavia non si verificano condizioni di competizione perché ogni uscita ha un singolo input di contropartita e le transazioni avvengono in namespace separati. Questo approccio per isolare insiemi di interazioni di processo/contratto essenzialmente divide lo spazio di indirizzamento di RChain in molti ambienti transazionali indipendenti, ciascuno dei quali è internamente concorrente e può essere eseguito in parallelo l'uno con l'altro.


.. figure:: .. /img/blocks-by-namespace.png
    :align: center
    :width: 1950
	:height: 1050
    :scale: 40
    
    Figura - Namespace come ambienti transazionali isolati
    

Tuttavia, in questa rappresentazione, resta il fatto che le risorse sono visibili a processi/contratti che conoscono il nome di un canale e soddisfano una corrispondenza di modello. Dopo aver partizionato lo spazio degli indirizzi in un multiplex di ambienti transazionali isolati, come possiamo ulteriormente perfezionare il tipo di processo/contratto che può interagire con una risorsa in un ambiente simile? —— a quali condizioni, e in che misura, può farlo? Per questo ci rivolgiamo alle definizioni.

Definizioni dei Namespace
============================================================
**Una definizione di namespace è una descrizione formulare delle condizioni minime richieste affinché un processo/contratto funzioni in un namespace.** In realtà, la consistenza di un namespace dipende immediatamente e esclusivamente dal modo in cui tale spazio definisce un nome, che può variare notevolmente a seconda della funzione prevista dei contratti descritta nella definizione del namespace.

Un nome soddisfa una definizione o no; funziona, o no. La seguente definizione del namespace è implementata come ‘se condizionale’ nell'interazione che descrive un insieme di processi che inviano un insieme di contratti a un insieme di indirizzi nominati che comprendono un namespace:


.. figure:: .. /img/namespace-definitions.png
    :align: center
    :width: 2659
	:height: 1588
    :scale: 40
    
    Figura - Una definizione di namespace implementata come ‘condizionale’
    
    

1. Un insieme di contratti, :code:`contract1...contractn` , viene inviato all'insieme di canali (namespace) :code:`address1...addressn`.

2. In parallelo, un processo ascolta l'input su ogni canale nel namespace :code:`address`. 

3. Quando un contratto viene ricevuto su uno qualsiasi dei canali, viene fornito a :code:`if cond.`, che controlla l'origine del namespace, l'indirizzo del mittente, il comportamento del contratto, la struttura del contratto, così come la dimensione dei dati che il contratto trasporta. 

4. Se tali proprietà sono coerenti con quelle indicate dalla definizione del namespace :code:`address`, la continuazione :code:`P` viene eseguita con :code:`contract` come argomento.

Una definizione di namespace limita in modo effettivo i tipi di interazioni che possono verificarsi in un namespace, con ogni contratto esistente nello spazio che dimostra un comportamento comune e prevedibile. Cioè, le alterazioni di stato invocate da un contratto che risiedono in un namespace sono necessariamente autorizzate, definite e corrette per tale namespace. Questa scelta progettuale semplifica e rende le query in stile datalog veloci, convenienti ed estremamente utili rispetto ai namespace.

Una definizione di namespace può controllare le interazioni che si verificano nello spazio, ad esempio specificando:

* Indirizzi accettati
* Namespace accettati
* Tipi comportamentali accettati
* Dimensione dati max/min
* Struttura I/O

Una definizione può, e spesso lo farà, specificare un insieme di spazi dei nomi e indirizzi accettati che possono comunicare con gli agenti che definisce.

Si noti il ​​controllo rispetto ai tipi comportamentali nel grafico sopra. Ciò esiste per garantire che la sequenza di operazioni espressa dal contratto sia coerente con le specifiche di sicurezza del namespace. I controlli di tipo comportamentale possono valutare le proprietà di liveness, termination, deadlock freedom e sincronizzazione delle risorse - tutte proprietà che garantiscono che le alterazioni dello stato delle risorse all'interno del namespace siano “sicure” al massimo. Poiché i tipi comportamentali denotano la sequenza operativa, i criteri del tipo comportamentale possono specificare le post-condizioni del contratto, che possono, a loro volta, soddisfare le precondizioni di un successivo namespace. Di conseguenza, la struttura namespace supporta la composizione sicura, o un insieme "concatenato", di ambienti transazionali.

Namespace componibili - Indirizzamento risorse
=============================================================================
Fino a questo punto, abbiamo descritto i canali denominati come entità piatte e atomiche di ampiezza arbitraria. Con la riflessione e la struttura interna sui canali denominati, otteniamo la profondità.

Un namespace può essere pensato come un URI (Uniform Resource Identifier), mentre l'indirizzo di una risorsa può essere considerato come un URL (Uniform Resource Locator). La componente “percorso” dell'URL, :code:`scheme://a/b/c`, ad esempio, può essere visualizzato come equivalente a un indirizzo RChain. Cioè, una serie di canali nidificati dove ognuno prende i messaggi, con il canale denominato, :code:`a`, essendo il canale “superiore”.

Si osservi, tuttavia, che i percorsi URL non sempre si compongono. Prendi :code:`scheme://a/b/c` e :code:`scheme://a/b/d`. In uno schema URL tradizionale, i due non si compongono per fornire un percorso. Tuttavia, ogni percorso piatto è automaticamente un percorso ad albero e, in quanto alberi, questi *si* compongono per produrre un nuovo albero :code:`scheme://a/b/c+d`. Pertanto, gli alberi offrono un modello componibile per l'indirizzamento delle risorse.


.. figure:: .. /img/namespaces-as-tree-paths.png
    :align: center
    :width: 1617
    :scale: 40
    
    Figura - Percorsi albero componibili
    
    
Sopra, l'unificazione funziona come un algoritmo naturale per la corrispondenza e la scomposizione degli alberi e la corrispondenza e la decomposizione basate sull'unificazione forniscono la base della query. Per esplorare questa affermazione, riscriviamo la nostra sintassi percorso/albero in questo modo:

::

 scheme://a/b/c+d ↦ s: a(b(c,d))


Quindi si adatta la sintassi alle azioni I/O del rho-calcolus:

::

                                                      s!( a(b(c,d)) )

                                                      for( a(b(c,d)) <- s; if cond ){ P }
          
          
L'espressione superiore denota output - posiziona l'indirizzo della risorsa :code:`a(b(c,d)` sul canale denominato :code:`s`. The bottom expression denotes input. For the pattern that matches the form :code:`a(b(c,d))`, coming in on channel :code:`s`, se è soddisfatta una condizione, esegue la continuazione :code:`P`, con l'indirizzo :code:`a(b(c,d)` come argomento. Naturalmente, questa espressione implica :code:`s`, come un canale con nome, quindi viene rappresentata la struttura del canale adattata:


.. figure:: .. /img/namespaces-as-trees.png
    :align: center
    :width: 567
    :scale: 40
    
    Figura - Schema URL come canali nidificati nella struttura ad albero
    
    
Data una struttura di indirizzi esistente e l'accesso al namespace, un client può richiedere e inviare richieste a nomi all'interno di tale struttura di indirizzi. Ad esempio, quando i processi di I/O del rho-calcolus vengono posti in esecuzione simultanea, l'espressione seguente denota una funzione che colloca i processi quotati, :code:`(@Q,@R)` nel punto, :code:`a(b(c,d))`:

::

                                            for( a(b(c,d)) <- s; if cond ){ P } | s!( a(b(@Q,@R)) )


La fase di valutazione è scritta simbolicamente:

::

                                   for( a(b(c,d)) <- s; if cond ){ P } | s!( a(b(@Q,@R)) ) → P{ @Q := c, @R := d }


Cioè, :code:`P` viene eseguito in un ambiente in cui :code:`c` è sostituito per :code:`@Q`, e :code:`d` è sostituito per :code:`@R`. La struttura ad albero aggiornata è rappresentata come segue:


.. figure:: .. /img/tree-structure-substituted.png
    :align: center
    :width: 1688
    :scale: 30
    
    Figura - Posizionamento dei processi sui canali


Oltre a un insieme di canali flat, ad es. :code:`s1...sn` che si qualificano come namespace, ogni canale con struttura interna è di per sé un namespace. Pertanto, :code:`s`, :code:`a`, e :code:`b` possono imporre in maniera incrementale definizioni di namespace individuali analoghi a quelli forniti da un namespace piatto. In pratica, la struttura interna di un canale denominato è un albero di tipo-n di profondità e complessità arbitrarie in cui il canale "superiore", in questo caso :code:`s`, è solo uno dei tanti possibili nomi in :code:`s1...sn` che possiedono una struttura interna.

Questa struttura di indirizzamento delle risorse rappresenta un adattamento passo dopo passo a quello che è lo standard di indirizzamento Internet più utilizzato nella storia. RChain raggiunge lo spazio compositivo degli indirizzi necessario per la visibilità privata, pubblica e del consorzio attraverso i namespace, ma l'ovvio caso d'uso affronta la scalabilità. Non a caso, non sorprendentemente, i namespace offrono anche una struttura per la soluzione di condivisione di RChain.


.. [5] Namespace Logic - A Logic for a Reflective Higher-Order Calculus.

