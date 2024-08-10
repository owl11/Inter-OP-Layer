# The Inter-OP Layer

At the intersection of L2's, we found interoperability.

## About

The Inter-OP Layer is a set of experimental contracts that seek unify the entry point to all OP-Stack compatible chains, Our goal is to enhance interoperability across various OP L2's (and perhaps one day All Layer 2's).

DISCLAIMER: These contracts have not been audited, and are highly experimental, they are provided on an "as is" basis, users should proceed at their own risk.


- [etc](#etc-wip) : expriemetnal contracts meant to work on top of the existing Bedrock contracts, much like the [Bedrock-utils](#bedrock-utils) except they aren't functional just yet, and only include an experimental Create2Deployer built on top of the existing crossDomainMessanger

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

## contracts overview:


### Bedrock Utils

Wrapper contracts that are not related to the prior components, they simply enable batch sending and retrieval of multiple OP Chains Bedrock contracts such as the Standard bridge, as well as an expirmental Create2 cross chain deployer, these do not modify any of the existing OP bedrock contracts

### Constants

Constants lib that make fetching multiple OP chain's addresses, and chain ID's simpler for our contracts, and potentially any contracts that seek to enhance interoperability on top of the OP-Stack, think of them as a similar contracts to the `predeploys.sol` in the OP-Stack.

### etc

place holder contracts and mocks.

## BUGS AND IMPROVEMENTS

The batch senders in both the forks and the wrappers will fail in the case one transfer fails, there is a solution to that, which is wrapping the calls in encoded calls rather than functoin calls, but for now be wary when using it

imrovement: batch sending is done to the msg sender only, build a function that batch sends to an array of recipents on the L1 standard bridge

please do provide feedback by submitting an issue, anything you see off or any potential improvements

ATTENTION: These contracts are configured for testnet usage, and remain highly expriemental, and only tested at Sepolia or similar testnets, in order to use them for production use or mainnet, further configurations/modifications are due, please be advised.
