// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {OP_CHAIN_IDS_TESTNETS} from "./OPChainID_Testnet.sol";
import {L2Create2Addresses} from "../Constants/L2Create2Addresses.sol";
import {OP_CHAINS_ADDRESSES_T} from "./L1OptimismAddresses_Testnet.sol";
/// @title OPAddressRegistry
/// @notice A registry for storing OP chain addresses based on chain IDs.

contract OPAddressRegistry_Testnet {
    uint256[] public SUPPORTED_CHAIN_IDS_SEPOLIA;
    uint256[] public SUPPORTED_CHAIN_IDS_HOLESKY;
    address[] public SUPPORTED_CHAIN_IDS_C2_SEPOLIA;

    // Struct to hold the addresses for various contracts on an OP chain

    struct ChainAddresses {
        address crossDomainMessenger;
        address standardBridge;
        address optimismPortal;
    }
    // Add more addresses as needed

    // Mapping from chain ID to its corresponding addresses
    mapping(uint256 => ChainAddresses) private OPchainAddressse;
    mapping(uint256 => address) private OPchainC2Addressse;

    // Event to log updates to the registry
    event AddressesUpdated(uint256 indexed chainID, ChainAddresses addresses);

    // Constructor to initialize the registry with known chain addresses
    constructor() {
        SUPPORTED_CHAIN_IDS_SEPOLIA.push(OP_CHAIN_IDS_TESTNETS.OP_SEPOLIA_TESTNET_CHAIN_ID);
        SUPPORTED_CHAIN_IDS_SEPOLIA.push(OP_CHAIN_IDS_TESTNETS.ZORA_SEPOLIA_TESTNET_CHAIN_ID);
        SUPPORTED_CHAIN_IDS_SEPOLIA.push(OP_CHAIN_IDS_TESTNETS.BASE_SEPOLIA_TESTNET_CHAIN_ID);
        SUPPORTED_CHAIN_IDS_SEPOLIA.push(OP_CHAIN_IDS_TESTNETS.MODE_SEPOLIA_TESTNET_CHAIN_ID);
        SUPPORTED_CHAIN_IDS_SEPOLIA.push(OP_CHAIN_IDS_TESTNETS.ORDERLY_SEPOLIA_TESTNET_CHAIN_ID);
        SUPPORTED_CHAIN_IDS_SEPOLIA.push(OP_CHAIN_IDS_TESTNETS.LISK_SEPOLIA_TESTNET_CHAIN_ID);
        SUPPORTED_CHAIN_IDS_SEPOLIA.push(OP_CHAIN_IDS_TESTNETS.PGN_SEPOLIA_TESTNET_CHAIN_ID);

        SUPPORTED_CHAIN_IDS_HOLESKY.push(OP_CHAIN_IDS_TESTNETS.METAL_L2_HOLESKY_CHAIN_ID);
        SUPPORTED_CHAIN_IDS_HOLESKY.push(OP_CHAIN_IDS_TESTNETS.CELO_DANGO_HOLESKY_TESTNET_CHAIN_ID);
        SUPPORTED_CHAIN_IDS_HOLESKY.push(OP_CHAIN_IDS_TESTNETS.FRAXTAL_HOLESKY_TESTNET_CHAIN_ID);

        SUPPORTED_CHAIN_IDS_C2_SEPOLIA.push(L2Create2Addresses.SEPOLIA_CREATE2_OP_ADDR);
        SUPPORTED_CHAIN_IDS_C2_SEPOLIA.push(L2Create2Addresses.SEPOLIA_CREATE2_ZORA_ADDR);
        SUPPORTED_CHAIN_IDS_C2_SEPOLIA.push(L2Create2Addresses.SEPOLIA_CREATE2_BASE_ADDR);
        SUPPORTED_CHAIN_IDS_C2_SEPOLIA.push(L2Create2Addresses.SEPOLIA_CREATE2_MODE_ADDR);
        SUPPORTED_CHAIN_IDS_C2_SEPOLIA.push(L2Create2Addresses.SEPOLIA_CREATE2_LISK_ADDR);
        SUPPORTED_CHAIN_IDS_C2_SEPOLIA.push(L2Create2Addresses.SEPOLIA_CREATE2_ORDERLY_ADDR);
        SUPPORTED_CHAIN_IDS_C2_SEPOLIA.push(L2Create2Addresses.SEPOLIA_CREATE2_PGN_ADDR);

        OPchainC2Addressse[OP_CHAIN_IDS_TESTNETS.OP_SEPOLIA_TESTNET_CHAIN_ID] =
            L2Create2Addresses.SEPOLIA_CREATE2_OP_ADDR;
        OPchainC2Addressse[OP_CHAIN_IDS_TESTNETS.ZORA_SEPOLIA_TESTNET_CHAIN_ID] =
            L2Create2Addresses.SEPOLIA_CREATE2_OP_ADDR;
        OPchainC2Addressse[OP_CHAIN_IDS_TESTNETS.BASE_SEPOLIA_TESTNET_CHAIN_ID] =
            L2Create2Addresses.SEPOLIA_CREATE2_OP_ADDR;
        OPchainC2Addressse[OP_CHAIN_IDS_TESTNETS.MODE_SEPOLIA_TESTNET_CHAIN_ID] =
            L2Create2Addresses.SEPOLIA_CREATE2_OP_ADDR;
        OPchainC2Addressse[OP_CHAIN_IDS_TESTNETS.ORDERLY_SEPOLIA_TESTNET_CHAIN_ID] =
            L2Create2Addresses.SEPOLIA_CREATE2_OP_ADDR;
        OPchainC2Addressse[OP_CHAIN_IDS_TESTNETS.PGN_SEPOLIA_TESTNET_CHAIN_ID] =
            L2Create2Addresses.SEPOLIA_CREATE2_OP_ADDR;
        OPchainC2Addressse[OP_CHAIN_IDS_TESTNETS.LISK_SEPOLIA_TESTNET_CHAIN_ID] =
            L2Create2Addresses.SEPOLIA_CREATE2_OP_ADDR;

        // Example initialization
        OPchainAddressse[OP_CHAIN_IDS_TESTNETS.OP_SEPOLIA_TESTNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_T.OP_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_T.OP_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_T.OP_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_TESTNETS.ZORA_SEPOLIA_TESTNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_T.ZORA_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_T.ZORA_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_T.ZORA_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_TESTNETS.BASE_SEPOLIA_TESTNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_T.BASE_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_T.BASE_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_T.BASE_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_TESTNETS.MODE_SEPOLIA_TESTNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_T.MODE_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_T.MODE_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_T.MODE_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_TESTNETS.ORDERLY_SEPOLIA_TESTNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_T.ORDERLY_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_T.ORDERLY_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_T.ORDERLY_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_TESTNETS.PGN_SEPOLIA_TESTNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_T.PGN_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_T.PGN_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_T.PGN_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_TESTNETS.LISK_SEPOLIA_TESTNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_T.LISK_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_T.LISK_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_T.LISK_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_TESTNETS.FRAXTAL_HOLESKY_TESTNET_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_T.FRAXTAL_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_T.FRAXTAL_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_T.FRAXTAL_L1_OPTIMISM_PORTAL
        });

        OPchainAddressse[OP_CHAIN_IDS_TESTNETS.METAL_L2_HOLESKY_CHAIN_ID] = ChainAddresses({
            crossDomainMessenger: OP_CHAINS_ADDRESSES_T.METAL_L1_CROSS_DOMAIN_MESSENGER,
            standardBridge: OP_CHAINS_ADDRESSES_T.METAL_L1_STANDARD_BRIDGE,
            optimismPortal: OP_CHAINS_ADDRESSES_T.METAL_L1_OPTIMISM_PORTAL
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

    function getC2Addresses(uint256 chainID) public view returns (address _c2Address) {
        _c2Address = OPchainC2Addressse[chainID];
        if (_c2Address <= address(0)) {
            revert();
        }
        return (_c2Address);
    }

    /// @notice Update the addresses for a specific chain ID
    /// @param _chainID The chain ID to update
    function isOPAlligned(uint256 _chainID) internal view returns (bool) {
        uint256[] memory supportedChainIDs = SUPPORTED_CHAIN_IDS_SEPOLIA;
        for (uint256 i = 0; i < supportedChainIDs.length; i++) {
            if (_chainID == supportedChainIDs[i]) {
                return true;
            }
        }
        return false;
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
