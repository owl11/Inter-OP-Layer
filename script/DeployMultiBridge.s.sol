// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {MultiDomain_L1Bridge} from "../src//Bedrock-Utils/MultiDomain_L1Bridge.sol";

contract DeployMultiBridge is Script {
    function run() external returns (MultiDomain_L1Bridge, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig(); // This comes with our mocks!

        (uint256 deployerKey) = helperConfig.activeNetworkConfig();
        vm.startBroadcast(deployerKey);
        MultiDomain_L1Bridge multi_Bridge = new MultiDomain_L1Bridge();
        vm.stopBroadcast();
        return (multi_Bridge, helperConfig);
    }
}
