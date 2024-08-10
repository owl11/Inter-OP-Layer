// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "./HelperConfig.s.sol";
import {Multi_L1STDBridge} from "../src//Bedrock-Utils/Multi_L1STDBridge.sol";

contract DeployMultiBridge is Script {
    function run() external returns (Multi_L1STDBridge, HelperConfig) {
        HelperConfig helperConfig = new HelperConfig(); // This comes with our mocks!

        (uint256 deployerKey) = helperConfig.activeNetworkConfig();
        vm.startBroadcast(deployerKey);
        Multi_L1STDBridge multi_Bridge = new Multi_L1STDBridge();
        vm.stopBroadcast();
        return (multi_Bridge, helperConfig);
    }
}
