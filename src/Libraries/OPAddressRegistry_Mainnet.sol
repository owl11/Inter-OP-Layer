// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {OP_CHAIN_IDS_MAINNET} from "./OPChainID_Mainnet.sol";
import {OP_CHAINS_ADDRESSES_M} from "./L1OptimismAddresses_Mainnet.sol";
/// @title OPAddressRegistry
/// @notice A registry for storing OP chain addresses based on chain IDs.

contract OPAddressRegistry {
    // Struct to hold the addresses for various contracts on an OP chain
    struct ChainAddresses {
        address crossDomainMessenger;
        address standardBridge;
        address optimismPortal;
    }
    // Add more addresses as needed

    // Mapping from chain ID to its corresponding addresses
    mapping(uint256 => ChainAddresses) private OPchainAddressse;

    // Event to log updates to the registry
    event AddressesUpdated(uint256 indexed chainID, ChainAddresses addresses);

    // Constructor to initialize the registry with known chain addresses
    constructor() {
        // Example initialization
        OPchainAddressse[OP_CHAIN_IDS_MAINNET.OP_MAINNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_M.OP_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_M.OP_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_M.OP_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_MAINNET.OP_MAINNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_M.ZORA_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_M.ZORA_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_M.ZORA_L1_OPTIMISM_PORTAL
        });
        OPchainAddressse[OP_CHAIN_IDS_MAINNET.OP_MAINNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_M.BASE_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_M.BASE_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_M.BASE_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_MAINNET.MODE_MAINNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_M.MODE_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_M.MODE_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_M.MODE_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_MAINNET.FRAXTAL_MAINNT_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_M.FRAXTAL_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_M.FRAXTAL_L1_CROSS_DOMAIN_MESSENGER,
            optimismPortal: OP_CHAINS_ADDRESSES_M.FRAXTAL_L1_CROSS_DOMAIN_MESSENGER
        });

        OPchainAddressse[OP_CHAIN_IDS_MAINNET.METAL_L2_MAINNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_M.METAL_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_M.METAL_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_M.METAL_L1_OPTIMISM_PORTAL
        });
    }

    /// @notice Fetch the addresses for a given chain ID
    /// @param chainID The chain ID to retrieve addresses for
    /// @return addresses The corresponding ChainAddresses struct
    function getAddresses(uint256 chainID) public view returns (address, address, address) {
        ChainAddresses memory addresses = OPchainAddressse[chainID];
        if (addresses.crossDomainMessenger <= address(0)) {
            revert();
        }
        return (addresses.crossDomainMessenger, addresses.standardBridge, addresses.optimismPortal);
    }

    /// @notice Update the addresses for a specific chain ID
    /// @param chainID The chain ID to update
    /// @param addresses The new ChainAddresses struct
    // function updateAddresses(uint256 chainID, ChainAddresses memory addresses) public {
    //     // Add access control here if needed
    //     chainAddressMap[chainID] = addresses;
    //     emit AddressesUpdated(chainID, addresses);
    // }
}
