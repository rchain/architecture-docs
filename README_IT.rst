*****************************
Architettura RChain
*****************************

La descrizione dell'architettura della piattaforma RChain fornisce un progetto di alto livello per costruire un'infrastruttura di calcolo pubblico decentralizzata ed economicamente sostenibile. Il design di RChain è ispirato a quello dei precedenti blockchain; unifica decenni di ricerche nei campi della computazione concorrente e distribuita, della semantica formale e della progettazione del linguaggio di programmazione. La piattaforma RChain vanta un design modulare, end-to-end, che si impegna a correggere la costruzione del software e l'estensibilità industriale.

PER INIZIARE
======================

Questo progetto utilizza Sphinx (http://www.sphinx-doc.org/en/stable/index.html) per creare html che viene pubblicato in Read the Docs. Per eseguire questa documentazione sul proprio computer, bisogna fare quanto segue:

Prerequisiti
--------------------------------------------------------------------------------
* Python 2.6 o successivo
* git

Installa Sphinx, etc
--------------------------------------------------------------------------------
Per utenti OSX/Linux (in base a queste istruzioni: https://read-the-docs.readthedocs.org/en/latest/getting_started.html)

* Dalla riga di comando: ``sudo pip install sphinx``

Per utenti Windows:

* http://www.sphinx-doc.org/en/stable/install.html#windows-install-python-and-sphinx

Ottieni il codice sorgente
--------------------------------------------------------------------------------
* git clone: https://github.com/rchain/architecture-docs.git

Costruisci e visualizza html
--------------------------------------------------------------------------------
* In una finestra del terminale, vai alla tua directory architecture-docs.
* ``make html``
* ``cd build/html``
* ``open index.html`` (aperire nel browser web)
* Suggerimento: ogni volta che esegui ``make html``, basta ricaricare il browser per visualizzare le modifiche
