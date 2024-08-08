// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title OP Contracts on L1 (Mainnet)
/// @notice Contains constant addresses for Most OP L2's that are documented.
library OP_CHAINS_ADDRESSES_M {
    
    //OPTIMISM Mainnet PROXY ADDRESSES
    address internal constant OP_L1_CROSS_DOMAIN_MESSENGER = 0x25ace71c97B33Cc4729CF772ae268934F7ab5fA1; // ResolvedDelegateProxy which routes calls to L1 cross domain messanger contract
    address internal constant OP_L1_STANDARD_BRIDGE = 0x99C9fc46f92E8a1c0deC1b1747d010903E884bE1; // L1ChugSplashProxy which routes calls to L1 Standard Bridge contract
    address internal constant OP_L1_OPTIMISM_PORTAL = 0xbEb5Fc579115071764c7423A4f12eDde41f106Ed; // L1ChugSplashProxy which routes calls to THe Optimism Portal contract

    //ZORA Mainnet
    address internal constant ZORA_L1_CROSS_DOMAIN_MESSENGER = 0xdC40a14d9abd6F410226f1E6de71aE03441ca506;
    address internal constant ZORA_L1_STANDARD_BRIDGE = 0x3e2Ea9B92B7E48A52296fD261dc26fd995284631;
    address internal constant ZORA_L1_OPTIMISM_PORTAL = 0x1a0ad011913A150f69f6A19DF447A0CfD9551054;

    //BASE Mainnet
    address internal constant BASE_L1_CROSS_DOMAIN_MESSENGER = 0x866E82a600A1414e583f7F13623F1aC5d58b0Afa;
    address internal constant BASE_L1_STANDARD_BRIDGE = 0x3154Cf16ccdb4C6d922629664174b904d80F2C35;
    address internal constant BASE_L1_OPTIMISM_PORTAL = 0x49048044D57e1C92A77f79988d21Fa8fAF74E97e;

    //MODE Mainnet
    address internal constant MODE_L1_CROSS_DOMAIN_MESSENGER = 0x95bDCA6c8EdEB69C98Bd5bd17660BaCef1298A6f; 
    address internal constant MODE_L1_STANDARD_BRIDGE = 0x735aDBbE72226BD52e818E7181953f42E3b0FF21; 
    address internal constant MODE_L1_OPTIMISM_PORTAL = 0x8B34b14c7c7123459Cf3076b8Cb929BE097d0C07; 

    //Fraxtal Mainnet
    address internal constant FRAXTAL_L1_CROSS_DOMAIN_MESSENGER = 0x126bcc31Bc076B3d515f60FBC81FddE0B0d542Ed;
    address internal constant FRAXTAL_L1_STANDARD_BRIDGE = 0x34C0bD5877A5Ee7099D0f5688D65F4bB9158BDE2;
    address internal constant FRAXTAL_L1_OPTIMISM_PORTAL = 0x36cb65c1967A0Fb0EEE11569C51C2f2aA1Ca6f6D;

    //Metal L2 Mainnet
    address internal constant METAL_L1_CROSS_DOMAIN_MESSENGER = 0x25ace71c97B33Cc4729CF772ae268934F7ab5fA1;
    address internal constant METAL_L1_STANDARD_BRIDGE = 0x99C9fc46f92E8a1c0deC1b1747d010903E884bE1;
    address internal constant METAL_L1_OPTIMISM_PORTAL = 0xbEb5Fc579115071764c7423A4f12eDde41f106Ed;

    //Celo Django Holesky
    // address internal constant CELO_DJANGO_CROSS_DOMAIN_MESSENGER = address(0);
    // address internal constant CELO_DJANGO_STANDARD_BRIDGE = address(0);
    // address internal constant CELO_DJANGO_OPTIMISM_PORTAL = address(0);
}
