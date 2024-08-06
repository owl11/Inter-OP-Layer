// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title OP Contracts on L1 (testnet)
/// @notice Contains constant addresses for Most OP L2's that are documented.
library OP_CHAINS_ADDRESSES_T {
    
    //OPTIMISM SEPOLIA PROXY ADDRESSES
    address internal constant OP_L1_CROSS_DOMAIN_MESSENGER = 0x58Cc85b8D04EA49cC6DBd3CbFFd00B4B8D6cb3ef; // ResolvedDelegateProxy which routes calls to L1 cross domain messanger contract
    address internal constant OP_L1_STANDARD_BRIDGE = 0xFBb0621E0B23b5478B630BD55a5f21f67730B0F1; // L1ChugSplashProxy which routes calls to L1 Standard Bridge contract
    address internal constant OP_L1_OPTIMISM_PORTAL = 0x16Fc5058F25648194471939df75CF27A2fdC48BC; // L1ChugSplashProxy which routes calls to THe Optimism Portal contract

    //ZORA SEPOLIA
    address internal constant ZORA_L1_CROSS_DOMAIN_MESSENGER = 0x1bDBC0ae22bEc0c2f08B4dd836944b3E28fe9b7A;
    address internal constant ZORA_L1_STANDARD_BRIDGE = 0x5376f1D543dcbB5BD416c56C189e4cB7399fCcCB;
    address internal constant ZORA_L1_OPTIMISM_PORTAL = 0x1aeeb910EAad354eEC3C1266a1637CB15b9EBB2B;

    //BASE SEPOLIA
    address internal constant BASE_L1_CROSS_DOMAIN_MESSENGER = 0xC34855F4De64F1840e5686e64278da901e261f20;
    address internal constant BASE_L1_STANDARD_BRIDGE = 0xfd0Bf71F60660E2f608ed56e1659C450eB113120;
    address internal constant BASE_L1_OPTIMISM_PORTAL = 0x49f53e41452C74589E85cA1677426Ba426459e85;

    //MODE SEPOLIA PROXY ADDRESSES
    address internal constant MODE_L1_CROSS_DOMAIN_MESSENGER = 0xc19a60d9E8C27B9A43527c3283B4dd8eDC8bE15C; 
    address internal constant MODE_L1_STANDARD_BRIDGE = 0xbC5C679879B2965296756CD959C3C739769995E2; 
    address internal constant MODE_L1_OPTIMISM_PORTAL = 0x320e1580effF37E008F1C92700d1eBa47c1B23fD; 

    //Fraxtal SEPOLIA
    address internal constant FRAXTAL_L1_CROSS_DOMAIN_MESSENGER = 0x45A98115D5722C6cfC48D711e0053758E7C0b8ad;
    address internal constant FRAXTAL_L1_STANDARD_BRIDGE = 0x0BaafC217162f64930909aD9f2B27125121d6332;
    address internal constant FRAXTAL_L1_OPTIMISM_PORTAL = 0xB9c64BfA498d5b9a8398Ed6f46eb76d90dE5505d;

    //Metal L2 SEPOLIA
    address internal constant METAL_L1_CROSS_DOMAIN_MESSENGER = 0x58Cc85b8D04EA49cC6DBd3CbFFd00B4B8D6cb3ef;
    address internal constant METAL_L1_STANDARD_BRIDGE = 0xFBb0621E0B23b5478B630BD55a5f21f67730B0F1;
    address internal constant METAL_L1_OPTIMISM_PORTAL = 0x16Fc5058F25648194471939df75CF27A2fdC48BC;

    //Celo Django Holesky
    address internal constant CELO_DJANGO_CROSS_DOMAIN_MESSENGER = 0x0be65c09d5880143cb9C2D6E45474972eFC4C13B;
    address internal constant CELO_DJANGO_STANDARD_BRIDGE = 0x9FEBd0F16b97e0AEF9151AF07106d733E87B1be4;
    address internal constant CELO_DJANGO_OPTIMISM_PORTAL = 0xB29597c6866c6C2870348f1035335B75eEf79d07;
}
