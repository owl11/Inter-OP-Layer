// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Script} from "forge-std/Script.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {Test, console} from "forge-std/Test.sol";

import {CREATE2Deployer} from "../src/etc/CREATE2Deployer.sol";
import {L1ContractDeployer} from "../src/etc/L1ContractDeployer.sol";
import {OPAddressRegistry_Testnet, OP_CHAIN_IDS_TESTNETS} from "../../src/Constants/OPAddressRegistry_testnet.sol";

contract Deploy_L1ToL2Deployer is Script, OPAddressRegistry_Testnet {
    CREATE2Deployer create2Deployer;
    L1ContractDeployer L1Deployer;
    address L1deployerAddr;
    address L2Create2Addr;

    address deployer = address(1);

    function run() external returns (CREATE2Deployer, L1ContractDeployer) {
        (uint256 deployerKey) = vm.envUint("PRIVATE_KEY");

        // deployer = vm.addr(deployerKey);

        L1deployerAddr = vm.computeCreateAddress(deployer, _replaceWithNonce);
        L2Create2Addr = vm.computeCreateAddress(deployer, _replaceWithNonce);
        vm.startBroadcast(deployerKey);

        if (block.chainid == 11155111) {
            L1Deployer = new L1ContractDeployer();
            assert(address(L1Deployer) == L1deployerAddr);
        } else if (isOPAlligned(block.chainid)) {
            create2Deployer = new CREATE2Deployer(address(L1deployerAddr));

            assert(address(create2Deployer) == L2Create2Addr);
        }
        vm.stopBroadcast();

        return (create2Deployer, L1Deployer);
    }
}
