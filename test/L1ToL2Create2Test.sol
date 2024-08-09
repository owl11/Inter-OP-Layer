// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {console, Script} from "forge-std/Script.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {OPAddressRegistry_Testnet, OP_CHAIN_IDS_TESTNETS} from "../../src/Constants/OPAddressRegistry_testnet.sol";
import {CREATE2Deployer} from "../src/etc/CREATE2Deployer.sol";
import {L1ContractDeployer} from "../src/etc/L1ContractDeployer.sol";

contract L1ToL2Create2Test is StdCheats, Test, OPAddressRegistry_Testnet {
    L1ContractDeployer L1Deployer;
    CREATE2Deployer create2Deployer;

    uint256 deployerPrivateKey;
    uint256 mainnetFork;
    uint256 optimismFork;

    bytes creationCode;

    function setUp() public {
        // deployerPrivateKey = vm.envUint("PRIVATE_KEY");

        L1Deployer = new L1ContractDeployer();
        creationCode = L1Deployer.getCreationCode();

        create2Deployer = new CREATE2Deployer(address(L1Deployer));
    }

    function testL1Simulate() public {
        (uint256 estimate, bool success, bytes memory returnData) = L1Deployer.simulateCreate2(creationCode, 1);
        console.log(estimate);
        console.log(success);
        console.logBytes(returnData);
    }

    function testL1ToL2Deploy() public {
        (bool success, bytes memory returnData) =
            L1Deployer.deployOnL2ForTest(creationCode, address(create2Deployer), 1);
        console.log(success);
        console.logBytes(returnData);
    }

    // function
}
