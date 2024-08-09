// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {Script} from "forge-std/Script.sol";
import {OP_CHAIN_IDS_TESTNETS} from "../src/Constants/OPChainID_Testnet.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    struct NetworkConfig {
        uint256 deployerKey;
    }
    // This private key is the most public private key in web3

    uint256 public DEFAULT_ANVIL_PRIVATE_KEY = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;

    constructor() {
        if (block.chainid == 11_155_111 || block.chainid == OP_CHAIN_IDS_TESTNETS.OP_SEPOLIA_TESTNET_CHAIN_ID) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else {
            activeNetworkConfig = getOrCreateAnvilEthConfig();
        }
    }

    function getSepoliaEthConfig() public view returns (NetworkConfig memory sepoliaNetworkConfig) {
        sepoliaNetworkConfig = NetworkConfig({deployerKey: vm.envUint("PRIVATE_KEY")});
    }

    function getOrCreateAnvilEthConfig() public returns (NetworkConfig memory anvilNetworkConfig) {
        // Check to see if we set an active network config
        // if (activeNetworkConfig.wethUsdPriceFeed != address(0)) {
        //     return activeNetworkConfig;
        // }

        // vm.startBroadcast();
        // vm.stopBroadcast();

        anvilNetworkConfig = NetworkConfig({deployerKey: DEFAULT_ANVIL_PRIVATE_KEY});
    }
}
