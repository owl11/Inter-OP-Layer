## Overview

While the OP team is actively building out the [Interoperability layer](https://specs.optimism.io/interop/overview.html) for the L2 side of things, we set out to make the L1 contracts equally interoperable, with the aim of easing access to multiple chains at once, which means enabling batch-sending to multiple OP chains in single transaction and facilitating batch-sending of cross-Domain messages, as well as expiremental features in the works such as batch-deploy with create2 (WIP).

### Components


- [Bedrock-Universals-Forks](#bedrock-universals-forks) : The universal Bedrock contracts, modified to enable the the user facing contracts to work with multiple OP Chains (OP Portal's).
- [Libraries](#libraries): Libraries that make fetching simplify fetching multiple OP chain's addresses for enchanced interoperability.
- [Bedrock-contract-Forks](#bedrock-contracts-forks) : Modiffied Bedrock contracts that provide a unified way to access any and all OP-comptaible chains from the L1 and back.
  - [crossDomainMessanger](#cross-domain-messanger)
  - [Standard-Bridge](#standard-bridge)
  - [ERC721Bridge](#erc721-bridge)
  
## contracts overview:

### Bedrock contracts Forks

These contracts form the cornerstone of our Inter-OP, they build on existing OP contracts, and forked versions of the universal one's, it sets out to make the Original L1 bedrock contracts compatible with bridging to multiple chains at once, this is achieved by modifying only what is neccessary to make the contracts work without needing to change the existing infrastructure for existing OP chain, I.e OP Chains are compatible by default.

### Bedrock Universals Forks

These are modified bedrock contracts with added features that enable the user-facing Bedrock contracts we mentioned above to function with multiple chains at once.


### Cross domain Messanger

The classic L1 Cross domain messanger, only it is modified to function with multiple chains, it is made by modifying a few functions to accept an additional parameter `uint256 _targetChainID`, it also builds on the constants provided by the [Constants](#constants) lib contracts.

NOTICE: The `l2CrossDomainMessanger`is unchanged, since it registers deposits to the L2 at the OP-Node [level](https://docs.optimism.io/stack/protocol/rollup/deposit-flow#l2-processing), much like the OP Portal, these contracts aim to see how flexible the build could be while maintaining the kernel components that.

### Strandard-Bridge

Similarly, the Standard bridge builds upon the same foundations set out by the OP team in the bedrock contracts, it includes modified features akin to the L1 cross domain messanger, and it further extends this functionality to Bridge not only ETH, but Compatible ERC20's to multiple OP Chains.

### ERC721Bridge

Since the Standard bridge handles both ETH and ERC20's, this builds out on those foundations, to make it route an ERC-721 (NFT) to any OP-chain.
