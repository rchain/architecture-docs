.. _rhovm:

******************************************************************
Execution Model
******************************************************************
The compiled Rholang contract is executed on an instance of the Rho virtual machine (RhoVM). This virtual machine is derived from the computational model of the language, similar to other programming languages such as Scala and Haskell. In other words, there will be a tight coupling between Rholang and its VM, ensuring correctness. To allow clients to execute the VM, we’ll build a compiler pipeline that starts with Rholang code that is then compiled into intermediate representations (IRs) that are progressively closer to the metal, with each translation step being either provably correct, commercially tested in production systems, or both. This pipeline is illustrated in the figure below:

