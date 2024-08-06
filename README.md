# The Inter-OP Layer

At the intersection of L2's, we found interoperability.

## About

The Inter-OP Layer is a set of experimental contracts that seek unify the entry point to all OP-Stack compatible chains, Our goal is to enhance interoperability across various OP L2's (and perhaps one day All Layer 2's).

DISCLAIMER: These contracts have not been audited, and are highly experimental, they are provided on an "as is" basis, users should proceed at their own risk.

## Overview

While the OP team is actively building out the [Iteroperability layer](https://specs.optimism.io/interop/overview.html) for the L2 side of things, we set out to make the L1 contracts equally interoperable, this means enabling batch-sending to multiple OP chains in single transaction and facilitating batch-sending of cross-Domain messages.

### Components

- [Bedrock-Utils](#bedrock-Utils) : Utility contracts that wrap around the existing Standard bridge providing an easy and unified entry point to multiple PO chains, maintaining the status quo of each OP Chain's seperate L1 Cross Domain Messanger
- [Bedrock-Universals-Forks](#bedrock-universals-forks) : The universal Bedrock contracts, modified to enable the the user facing contracts to work with multiple OP Chains (OP Portal's).
- [Libraries](#libraries): Libraries that make fetching simplify fetching multiple OP chain's addresses for enchanced interoperability.
- [Bedrock-contract-Forks](#bedrock-contracts-forks) : Modiffied Bedrock contracts that provide a unified way to access any and all OP-comptaible chains from the L1 and back.
  - [crossDomainMessanger](#cross-domain-messanger)
  - [Standard-Bridge](#standard-bridge)
  - [ERC721Bridge](#erc721-bridge)
- [etc](#etc-wip) : expriemetnal contracts meant to work on top of the existin Bedrock contracts, much like the [Bedrock-utils](#bedrock-utils) except they aren't functional just yet, and only include an experimental Create2Deployer built on top of the existing crossDomainMessanger

## contracts overview:

### Bedrock contracts Forks

These contracts form the cornerstone of our Inter-OP, they build on existing OP contracts, and forked versions of the universal one's, it sets out to make the Original L1 bedrock contracts compatible with bridging to multiple chains at once, this is achieved by modifying only what is neccessary to make the contracts work without needing to change the existing infrastructure for existing OP chain, I.e OP Chains are compatible by default.

### Bedrock Universals Forks

These are modified bedrock contracts with added features that enable the user-facing Bedrock contracts we mentioned above to function with multiple chains at once.

### Bedrock Utils

Wrapper contracts that are not related to the prior components, they simply enable batch sending and retrieval of multiple OP Chains Bedrock contracts such as the Standard bridge, OP Portal and the Cross domain messanger, these do not modify any of the existing bed rock contracts.

### Libraries

Libraries that make fetching multiple OP chain's addresses, and chain ID's simpler for our contracts, and potentially any contracts that seek to enhance interoperability on top of the OP-Stack, think of them as a similar contracts to the `predeploys.sol` in the OP-Stack.

### Cross domain Messanger

The classic L1 Cross domain messanger, only it is modified to function with multiple chains, it is made by modifying a few functions to accept an additional parameter `uint256 _targetChainID`, it also builds on the constants provided by the [Libraries](#libraries) contracts.

NOTICE: The `l2CrossDomainMessanger`is unchanged, since it builds out on the older `crossdomainmessanger` universal contract, and updating it to the new one, has little to no benfit.

### Strandard-Bridge

Similarly, the Standard bridge builds upon the same foundations set out by the OP team in the bedrock contracts, it includes modified features akin to the L1 cross domain messanger, and it further extends this functionality to Bridge not only ETH, but Compatible ERC20's to multiple OP Chains.

### ERC721Bridge

Since the Standard bridge handles both ETH and ERC20's, this builds out on those foundations, to make it route an ERC-721 (NFT) to any OP-chain.

### etc (WIP)

expriemental features built out on top of the bedrock contracts that may have some benfit exploring further.

## Usage

#### Setup

1. Install the `contracts-bedrock` (v0.15.0) library (assuming you already have Node.js and yarn):

   ```sh
   cd foundry/lib
   yarn
   ```

2. Install the `Solmate` contracts library (perferrably with Forge):

   ```sh
   cd ..
   forge install transmissions11/solmate@v7 --no-git
   ```

3. Install the `Openzeppelin` contracts library, best done with a version that's prior to 5.0.0:

   ```sh
   forge install openzeppelin/openzeppelin-contracts@v4.9.6 --no-git
   ```

   from there, the contracts should compile just fine.

## BUGS AND IMPROVEMENTS

The batch senders in both the forks and the wrappers will fail in the case one transfer fails, there may be a solution to that, but for now be wary if using it

imrovement: batch sending is done to the msg sender only, build a function that batch sends to an array of recipents on the L1 standard bridge

please do provide feedback by submitting an issue, anything you see off or any potential improvements
