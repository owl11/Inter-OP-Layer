// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Script} from "forge-std/Script.sol";
import {HelperConfig, OP_CHAIN_IDS_TESTNETS} from "./HelperConfig.s.sol";
import {multiDomainMessenger} from "../src//Bedrock-Utils/multiDomainMessenger.sol";

contract DeployDSC is Script {
    function run() external returns (multiDomainMessenger) {
        HelperConfig helperConfig = new HelperConfig(); // This comes with our mocks!

        // (address wethUsdPriceFeed, address wbtcUsdPriceFeed, address weth, address wbtc, uint256 deployerKey) =
        //     helperConfig.activeNetworkConfig();
        // tokenAddresses = [weth, wbtc];
        // priceFeedAddresses = [wethUsdPriceFeed, wbtcUsdPriceFeed];

        (uint256 deployerKey) = helperConfig.activeNetworkConfig();
        vm.startBroadcast(deployerKey);
        multiDomainMessenger messanger = new multiDomainMessenger();
        vm.stopBroadcast();
        return (messanger);
    }
}
