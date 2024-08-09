// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {OP_CHAINS_ADDRESSES_T} from "./L1OptimismAddresses_Testnet.sol";

/// @title OP Contracts on L1 (testnet)
/// @notice Contains constant addresses for Most OP L2's that are documented.
library L2Create2Addresses {
    //OPTIMISM SEPOLIA PROXY ADDRESSES
    address public constant SEPOLIA_CREATE2_OP_ADDR = 0xBa9F9d16D7e15744992660F978FDCdF5664aB972;
    address public constant SEPOLIA_CREATE2_ZORA_ADDR = 0x1429859428C0aBc9C2C47C8Ee9FBaf82cFA0F20f;
    address public constant SEPOLIA_CREATE2_BASE_ADDR = 0x82a9Eb25D1d6D11275ecdb5d633B7A6faF1E1411;
    address public constant SEPOLIA_CREATE2_MODE_ADDR = 0xD1231bC958A8f80e3fcd200EEAe1e15d6548a3e9;
    address public constant SEPOLIA_CREATE2_LISK_ADDR = 0xe0AAFEaC0a2C2142E346a37E647DFfC174aa389b;
    address public constant SEPOLIA_CREATE2_ORDERLY_ADDR = 0x909032E39AB184C594E6ebD6c996435430F4e89b;
    address public constant SEPOLIA_CREATE2_PGN_ADDR = 0xe0AAFEaC0a2C2142E346a37E647DFfC174aa389b;
}
