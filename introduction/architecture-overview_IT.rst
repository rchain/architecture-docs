###################################
Panoramica dell'architettura
###################################
I componenti principali dell'architettura sono illustrati di seguito:


.. figure:: ../img/architecture-overview.png
   :align: center
   :width: 1135
   :scale: 50

   Figura - L'architettura di RChain


L'architettura di esecuzione può basarsi su alcuni componenti esterni specifici del funzionamento, ma questi vengono mantenuti su un minium essendo eseguiti sulla JVM. L’Execution Envirionment RhoVM viene eseguito sulla JVM, quindi le singole istanze RhoVM vengono eseguite all'interno dell’Execution Envirionment RhoVM.

Il **RhoVM Execution Environment** fornisce il contesto per l'esecuzione del contratto, il ciclo di vita delle singole istanze di RhoVM.   

Descrivendo i livelli rimanenti rappresentati, dal basso verso l'alto:

**Comunicazione P2P** supporta le comunicazioni da nodo a nodo. Questo sarà un componente open-source TBD di tipo commerciale come ZeroMQ o RabbitMQ.

**Archiviazione** avviene tramite MongoDB, un datastore a valore-chiave. La struttura dati principale in memoria è un albero radix (trie).

**Data Abastraction Layer** fornisce l'accesso monadico ai dati e ad altri nodi in modo coerente, come se fossero locali. Questo livello rappresenta un'evoluzione della tecnologia SpecialK (inclusi la distribuzione decentralizzata dei propri contenuti, database con valori-chiave, messaggistica tra nodi e modelli di accesso ai dati). Questo livello è in fase di implementazione in Rholang e quindi si basa **sull'interfaccia di funzione esterna** di RhoVM-EE e Rholang per accedere alla comunicazione e all’archiviazione P2P.

**Consenso** (Protocollo di validazione/consenso Proof-of-Stake di Casper) assicura il consenso del nodo sullo stato di ogni blockchain.

Tutti i nodi RChain includono **Contratti di sistema** essenziali, che sono scritti in Rholang. I processi di sistema includono quelli per l'esecuzione di istanze RhoVM, il bilanciamento del carico, la gestione dei contratti dApp, i token, l’affidabilità del nodo e altri.

I contratti del sistema Token includono quelli richiesti per eseguire protocolli che interagiscono oltre il nodo locale. Questi sono *token di accesso al protocollo*. (PAT). Esistono due tipi di PAT:
 * **I token della posta** sono quelli necessari per eseguire il consenso, incluso il token **RChain Rev**. Ulteriori token della posta possono essere introdotti tramite versioni ufficiali del software. Per pagare le risorse del nodo *è necessario un token di accatastamento*. **Phlogiston** è la misura di RChain del costo delle risorse (simile a *gas* in Ethereum), ed è multi-dimensionale e dipende dall'uso delle risorse del calcolo (in base all'istruzione), dall'archiviazione (a seconda delle dimensioni e della durata), e dalla larghezza di banda (qualità del servizio e throughput). Vedi anche la sezione intitolata "Meccanismo del fattore limitante."

 + **I token dell'applicazione** sono facoltativi e potrebbero essere necessari per eseguire determinate dApp. Nuovi token di applicazione possono essere introdotti in qualsiasi momento da uno sviluppatore di dApp e sono simili ai token di ERC20 di Ethereum.

**L'API Rho** fornisce l'accesso all’Execution Environment e al nodo. **Language Bindings** sarà disponibile per i linguaggi di programmazione scritti rispetto a JVM e potenzialmente altri. Verrà fornito uno strumento di sviluppo **REPL** (lettura, esecuzione, stampa e loop). Ogni nodo avrà una CLI **Command Line Interface**.  Un **Nodo API** esporrà le funzionalità tramite http e RPC json.

Concorrenza vs parallelismo
----------------------------------------
È essenziale che il lettore comprenda le implicazioni dell'esecuzione concorrente. Quando diciamo “concorrenza”, non ci riferiamo all'esecuzione simultanea di più processi. Questo è il parallelismo. La *Concorrenza* è una proprietà strutturale che consente ai processi indipendenti di comporsi in processi complessi. I processi sono considerati indipendenti se non competono per le risorse.

Dal momento che RChain si è impegnato nella concorrenza in Rholang e RhoVM, vedremo che otterremo parallelismo e asincronia come proprietà emergenti “libere”. Se la piattaforma è in esecuzione su un processore o su 1.000.000 processori, il design RChain è scalabile. Detto questo, il lettore di questo documento noterà sempre i modelli di progettazione della computazione concorrente.

###################################
Semantica del nodo e della blockchain
###################################
Il seguente diagramma di classe UML illustra le classi concettuali primarie e le relazioni strutturali.

.. Figure:: ../img/RChainBlockchainStructuralSemantics.png
   :align: center
   :width: 90%

   Figura - Semantica strutturale di Blockchain RChain
