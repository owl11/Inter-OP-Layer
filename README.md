# The Inter-OP Layer

At the intersection of L2's, we found interoperability.

## About

The Inter-OP Layer is a set of experimental contracts that seek unify the entry point to all OP-Stack compatible chains, Our goal is to enhance interoperability across various OP L2's (and perhaps one day All Layer 2's).

DISCLAIMER: These contracts have not been audited, and are highly experimental, they are provided on an "as is" basis, users should proceed at their own risk.


- [Bedrock Utils](#Bedrock Utils) : expriemetnal contracts meant to work on top of the existing Bedrock contracts, much like the [Bedrock-utils](#bedrock-utils) except they aren't functional just yet, and only include an experimental Create2Deployer built on top of the existing crossDomainMessanger

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

## DISCLAIMERS

ATTENTION: These contracts are configured for testnet usage, and remain highly expriemental, and only tested at Sepolia or similar testnets, in order to use them for production use or mainnet, further configurations/modifications are due, please be advised.

The current implementation seeks to unifiy the entry point to the optimism portal, while modifying everything in between, we treate the op portal as the modular kernel, aiming to not modify it, while touching upon everything surrounding it, while sufficient, ciritical assumptions were made, such as that the CrossDomain Messanger could've worked alongside the old one, this quickly got debunked upon further inspection, the aim of this fork was to bring upon a unified entry point, for now, the [Bedrock-Utils](#bedrock-Utils) are a good example of what it should do but with no changes to existing infra, they are deployed on [Sepolia](https://sepolia.etherscan.io/address/0x66449d17e24c52a4fb0ca88f98e3f5f4431a022d#code) and while the code is not yet finished, we have a poc of a multi deposit to 6 OP chains within the same [transaction](https://sepolia.etherscan.io/tx/0x9de12f0f3f8b495031ed195e263351698aec4a37e9d5403ef7c04d9d73bb0742), which gives a rough idea of what our goal is for the other modified versions of the Bedrock contracts.

## TEST IT?

### L1_MultiBridge

If you'd like to test the wrapper, you can go to the contract's webpage listed above, and input these entries in your favourite block explorer or click [here](https://sepolia.etherscan.io/address/0x66449d17e24c52a4fb0ca88f98e3f5f4431a022d#writeContract#F3) directly, from there you will populate the `quickDepositToAnyChain()` function with these parameters or similar:

```sh
0.1, [11155420, 999999999, 84532, 919, 4460, 58008, 4202]
```
where the 0.1 represents 0.1 Eth, which is insginifcat for testing on Sepolia, and the array of numbers is the OP chains our OP Chain registry has Defined.

### L1 to L2 Create2
The L1ToL2 create2 Deployer might need a bit more, but here is the conract address, feel free to DM me on X for help, [L1ContractDeployer](https://sepolia.etherscan.io/address/0xdf4685c2942c7b8518c36d115b6d12c3cac4577a#code) and the [L2Create2Deployer on Optimism](https://sepolia-optimism.etherscan.io/address/0xDF4685C2942c7b8518c36d115B6d12C3caC4577a#code) and multiple OP chains as well.

