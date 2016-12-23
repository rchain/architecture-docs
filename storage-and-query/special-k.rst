.. _special-k:

################################################################################
SpecialK - DSL for Data Access
################################################################################

SpecialK is the DSL for data access, and KVDB is the decentralized implementation
behind the DSL. SpecialK defines distributed data-access patterns in a consistent
way, as shown below.

+--------------------------+-----------------------------------------------+-----------------+-------------------+----------------------+
|                          | Item-level read & write (distributed locking) | DB read & write | Pub/Sub messaging | Pub/Sub with history |
+==========================+===============================================+=================+===================+======================+
| **Data**                 | Ephemeral                                     | Persistent      | Ephemeral         | Persistent           |
+--------------------------+-----------------------------------------------+-----------------+-------------------+----------------------+
| **Continuation** [#f1]_  | Ephemeral                                     | Ephemeral       | Persistent        | Persistent           |
+--------------------------+-----------------------------------------------+-----------------+-------------------+----------------------+
| **Producer Verb** [#f2]_ | Put                                           | Store           | Publish           | Publish with         |
|                          |                                               |                 |                   |                      |
|                          |                                               |                 |                   | history              |
+--------------------------+-----------------------------------------------+-----------------+-------------------+----------------------+
| **Consumer Verb**        | Get                                           | Read            | Subscribe         | Subscribe            |
+--------------------------+-----------------------------------------------+-----------------+-------------------+----------------------+

From the point of view of the SpecialK DSL and API, when it performs a data-access
action, such as the verb Get (with a pattern), it doesn’t need to know or care whether
it is stored locally or going out to the network. There is a single query mechanism
regardless.

The 2016 and prior SpecialK technology stack (Agent Services, SpecialK, and KVDB, with
RabbitMQ and MongoDB) delivered a decentralized Content Delivery Network, although it
was neither metered nor monetized. The SpecialK & KVDB components sit on top of MongoDB
and RabbitMQ to create the decentralized logic for storing and retrieving content, both
locally and remotely. The current 1.0 implementations of SpecialK and KVDB are written
in Scala and are in GitHub.

The query semantics vary depending on which level in the architecture is involved.
At the SpecialK level, prolog expressions are stored as part of the key and subsequently
queried via prolog (datalog) expressions. Higher up in the architecture, prolog expressions
of labels are used for storage, and datalog expressions of labels are used for query.

In RChain, the SpecialK and KVDB layers will be reimplemented in Rholang (versus the prior
implementation in Scala with custom implementation of delimited continuations and code
serialization).

For more information, see `SpecialK/KVDB – A Pattern Language for the Web`_.

.. [#f1] By convention a continuation function is represented as a parameter named k.
.. [#f2] This is only a subset of the verbs possible under this decomposition of the
         functionality. The verb fetch, for example, gets the data without leaving a
         continuation around, if there is no data available.

.. _SpecialK/KVDB – A Pattern Language for the Web: https://blog.synereo.com/2015/03/17/specialkkvdb-a-pattern-language-for-the-web/
