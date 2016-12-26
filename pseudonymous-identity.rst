.. _pseudonymous-identity:

################################################################################
Pseudonymous Identity and Cryptography
################################################################################

Like other Blockchains, RChain will use elliptic curve cryptography (ECC). The exact curve and address formats have not yet been selected.

There are several areas in which cryptography is employed, including:

* Transaction signing
* Data encryption per channel

  * based on Diffie–Hellman key exchange,
  * within and across nodes, and
  * in datastores

* Obscurity of keys and data in DHT
