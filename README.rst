
*****************************
RChain-Architecture
*****************************

The RChain platform architecture description provides a high-level blueprint to build a decentralized, economically sustainable public compute infrastructure. While the RChain design is inspired by that of earlier blockchains, it alone realizes decades of research across the fields of concurrent and distributed computation, mathematics, and programming language design. The platform boasts a modular, end-to-end design that commits to correct-by-construction software and industrial extensibility. 

GETTING STARTED
======================

This project uses Sphinx (http://www.sphinx-doc.org/en/stable/index.html) to build html that is published to Read the Docs. To run this documentation on your computer, you should do the following:

Prerequisites
--------------------------------------------------------------------------------
* Python 2.6 or later
* git

Install Sphinx, etc
--------------------------------------------------------------------------------
For OSX/Linux users (based on instructions here: https://read-the-docs.readthedocs.org/en/latest/getting_started.html)

* From command line: ``sudo pip install sphinx``

For Windows users:

* http://www.sphinx-doc.org/en/stable/install.html#windows-install-python-and-sphinx

Get source code
--------------------------------------------------------------------------------
* git clone: https://github.com/ethereum/homestead-guide.git

Build and view html
--------------------------------------------------------------------------------
* In a terminal window, go to your homestead-guide directory.
* ``make html``
* ``cd build/html``
* ``open index.html`` (open in web browser)
* Tip: each time you run ``make html``, just reload your browser to view changes
