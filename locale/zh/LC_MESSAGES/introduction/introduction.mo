��          |      �          &   !     H  v  U  y   �  �   F  �   @  O  �  �     ;  �    $
  o  D  Q  �          %  >  ,  �   k  �   �  v   �  �  I  �      !  �  �  �  2  �        	                                           
        Figure: High-level RChain Architecture Introduction Like other blockchains, achieving consensus across nodes on the state of the blockchain is essential. RChain's protocol for replication and consensus is called Casper and is a proof-of-stake protocol. Similar to Ethereum, a contract starts out in one state, many nodes receive a signed transaction, and then their RhoVM instances execute that contract to its next state. An array of node operators, or "bonded validators" apply the consensus algorithm to crypto-economically verify that the entire history of state configurations and state transitions, of the RhoVM instance, are accurately replicated in a distributed data store. Since nodes are internally concurrent, and each need not run all namespaces (blockchains), the system will be *scalable*. Since the contract language and its VM are build from the formal specifications of provable mathematics, and since the compiler pipeline and engineering approach is *correct by construction*, we expect the platform will be regarded as *trustworthy*. The RChain Network implements direct node-to-node communication, where each node runs the RChain platform and a set of dApps on the top of it. The blockchain contracts (aka smart contracts, processes, or programs), including system contracts included in the installation are written in the RChain general-purpose language “**Rholang**” (Reflective higher-order language). Derived from the rho-calculus computational formalism, Rholang supports internal programmatic concurrency. It formally expresses the communication and coordination of many processes executing in parallel composition. Rholang naturally accommodates industry trends in code mobility, reactive/monadic API’s, parallelism, asynchronicity, and behavioral types. The heart of an RChain is the Rho Virtual Machine (RhoVM) Execution Environment, which runs multiple RhoVMs that are each executing a smart contract. These execute concurrently and are multi-threaded. The open-source RChain project is building a *decentralized, economic, censorship-resistant, public compute infrastructure and blockchain*. It will host and execute programs popularly referred to as "smart contracts". It will be trustworthy, scalable, concurrent, with proof-of-stake consensus and content delivery. This concurrency, which is designed around on the formal models of mobile process calculi, along with an application of compositional namespaces, allows for what are in effect *multiple blockchains per node*. This multi-chain, independently executing virtual machine instances is in sharp contrast to a “global compute” design which constrains transactions to be executed sequentially, on a single virtual machine. In addition, each node can be configured to subscribe to and process the namespaces (blockchains) in which it is interested. Using smart contracts, a broad array of fully-scalable decentralized applications (dApps) can be built on the top of this platform. DApps may address areas such as identity, tokens, timestamping, financial services, monetized content delivery, Decentralized Autonomous Organizations (DAOs), exchanges, reputation, private social networks, marketplaces, and many more. Project-Id-Version: RChain Architecture 0.9
Report-Msgid-Bugs-To: 
POT-Creation-Date: 2018-01-18 16:26+0800
PO-Revision-Date: 2018-04-03 21:28+0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Generated-By: Babel 2.3.4
Last-Translator: 
Language-Team: 
Language: zh
X-Generator: Poedit 2.0.5
 图：高层次的RChain架构 介绍 像其他区块链一样，在区块链上实现跨节点的共识至关重要。RChain协议中关于副本和共识的部分被称为Casper，是一种权益证明(pos)的协议。类似于以太坊，合约在一种状态下开始，许多节点收到一个带签名的交易，然后在RhoVM实例上执行该合约并进入到下一状态。一系列节点运算符或“被绑定的验证器”将共识算法应用于加密-高效地验证RhoVM实例上状态的配置和状态转移的整个记录，并且这些都被精确的备份到分布式的数据存储中。 由于节点是内部并发的，每个节点不需要运行所有的命名空间（或者区块链），系统也将是 *可扩展* 的。 由于合约语言和虚拟机都是从可数学证明的形式化规范构建而来的，并且由于编译器设计和工程方法都是 *正确构建*的 ，我们认为这个平台将被视为 *值得信赖* 的。 RChain网络实现了直接的点到点的通信，每个节点运行RChain平台并在这之上运行一系列dApp。 区块链合约（也称为智能合同，进程或程序），包括在安装中被写入的系统合约，均使用RChain通用语言“**Rholang**”（高阶反射语言）编写。Rholang从rho-演算的计算形式论派生而来，支持内部程序并发。它形式化地表达了以并行组合方式执行的进程之间的通信和协调。Rholang自然地适应了代码的变迁，反射/一元 APIs，并行性，异步性和行为类型等行业趋势。 RChain的核心是Rho虚拟机（RhoVM），RChain可运行多个RhoVM，每个单独的RHoVM执行一个智能合约。这些虚拟机是并发执行的而且是多线程的。 开源的RChain项目构建了一个 *去中心化的，高实用的，自治的通用计算基础设施和区块链平台*。在平台上,可以创建和执行被称为“智能合约”的程序。它是可靠的、可扩展的和可并发的，并具有pos共识和内容分发功能。 所谓的并发性，是围绕移动进程演算的形式化模型而设计的，伴随可组合的命名空间应用，从而允许 **每个节点实际上有多条区块链**。这种多链、独立执行的虚拟机实例与“全局计算”的设计形成鲜明对比，后者限制了交易只能在单个虚拟机上顺序执行。另外，每个节点都可以配置为订阅和处理它感兴趣的命名空间（或区块链）。 通过使用智能合约，可以在此平台上构建大量可完全扩展的去中心化应用程序（dApp）。DApps可用于诸如身份，代币，时间戳，金融服务，货币化内容传输，去中心化自治组织（DAO），交易所，信用，私人社交网络和市场等诸多领域。 