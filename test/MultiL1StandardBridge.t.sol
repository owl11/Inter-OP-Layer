// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Script} from "forge-std/Script.sol";
import {HelperConfig} from "../script/HelperConfig.s.sol";
import {DeployMultiBridge} from "../script/DeployMultiBridge.s.sol";
import {Multi_L1STDBridge} from "../src/Bedrock-Utils/Multi_L1STDBridge.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {OPAddressRegistry_Testnet, OP_CHAIN_IDS_TESTNETS} from "../../src/Constants/OPAddressRegistry_testnet.sol";
import {OptimismMintableERC20} from "@eth-optimism/contracts-bedrock/contracts/universal/OptimismMintableERC20.sol";

contract MultiBridgeTest is StdCheats, Test, OPAddressRegistry_Testnet {
    uint256 mainnetFork;
    uint256 optimismFork;
    HelperConfig public helperConfig;
    address[] public RECIPIENTS;
    uint256[] public AMOUNTS;
    address[] public L1TOKENS;
    address[] public L2TOKENS;
    address public L1OUTb = 0x12608ff9dac79d8443F17A4d39D93317BAD026Aa;
    address public L2OUTb = 0x7c6b91D9Be155A6Db01f749217d76fF02A7227F2;

    Multi_L1STDBridge public multiBridge;
    uint256 public deployerKey;
    uint256 constant ONE_ETH = 1 ether;
    uint256 public constant STARTING_USER_BALANCE = 10 ether;
    address public user = address(1);
    uint256 deployerPrivateKey;

    function setUp() public {
        string memory SEPOLIA_RPC_URL = vm.envString("RPC_SEPOLIA");
        string memory SEPOLIA_OPTIMISM_RPC_URL = vm.envString("RPC_OPTIMISM_SEPOLIA");
        deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        mainnetFork = vm.createFork(SEPOLIA_RPC_URL);
        optimismFork = vm.createFork(SEPOLIA_OPTIMISM_RPC_URL);
        // if (block.chainid == 31_337) {
        vm.deal(user, STARTING_USER_BALANCE);
        // }
        vm.stopBroadcast();
    }

    function testCreateContract() public {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);
        DeployMultiBridge deployer = new DeployMultiBridge();
        (multiBridge, helperConfig) = deployer.run();
    }

    modifier contractCreated() {
        vm.selectFork(mainnetFork);
        assertEq(vm.activeFork(), mainnetFork);
        DeployMultiBridge deployer = new DeployMultiBridge();
        (multiBridge, helperConfig) = deployer.run();
        _;
    }

    function Recipient_Setup() public {
        // RECIPIENTS.push(address(1));
        RECIPIENTS.push(address(2));
        RECIPIENTS.push(address(3));
        RECIPIENTS.push(address(4));
        RECIPIENTS.push(address(5));
        RECIPIENTS.push(address(6));
        RECIPIENTS.push(address(7));
    }

    function L1Token_Setup() public {
        // RECIPIENTS.push(address(1));
        // vm.makePersistent(address(0));
        L1TOKENS.push(L1OUTb);
        L1TOKENS.push(L1OUTb);
        L1TOKENS.push(L1OUTb);
        L1TOKENS.push(L1OUTb);
        L1TOKENS.push(L1OUTb);
        L1TOKENS.push(L1OUTb);
    }

    function L2Token_Setup() public {
        // RECIPIENTS.push(address(1));
        L2TOKENS.push(L2OUTb);
        L2TOKENS.push(L2OUTb);
        L2TOKENS.push(L2OUTb);
        L2TOKENS.push(L2OUTb);
        L2TOKENS.push(L2OUTb);
        L2TOKENS.push(L2OUTb);
    }

    function Amounts_Setup() public {
        // AMOUNTS.push(0.01 ether);
        AMOUNTS.push(0.02 ether);
        AMOUNTS.push(0.03 ether);
        AMOUNTS.push(0.04 ether);
        AMOUNTS.push(0.05 ether);
        AMOUNTS.push(0.06 ether);
        AMOUNTS.push(0.07 ether);
    }

    function testDeposit() public contractCreated {
        vm.startBroadcast(deployerPrivateKey);
        multiBridge.quickDepositToAnyChain{value: ONE_ETH}(SUPPORTED_CHAIN_IDS_SEPOLIA);
        vm.stopBroadcast();
    }

    function testDepositAnyChains() public contractCreated {
        Recipient_Setup();
        Amounts_Setup();
        vm.startBroadcast(deployerPrivateKey);
        multiBridge.depositToAnyChain{value: ONE_ETH}(SUPPORTED_CHAIN_IDS_SEPOLIA, AMOUNTS);
        vm.stopBroadcast();
    }

    function testDepositManyToAddresses() public contractCreated {
        Recipient_Setup();
        Amounts_Setup();
        vm.startBroadcast(deployerPrivateKey);

        multiBridge.DepositToMultipleRecipients{value: ONE_ETH}(SUPPORTED_CHAIN_IDS_SEPOLIA, RECIPIENTS, AMOUNTS);
        vm.stopBroadcast();
    }

    function testDepositManyERC20() public contractCreated {
        Recipient_Setup();
        Amounts_Setup();
        L1Token_Setup();
        L2Token_Setup();
        vm.startBroadcast(deployerPrivateKey);
        IERC20(L1OUTb).approve(address(multiBridge), 1000 ether);
        multiBridge.depositERC20ToAnyChain(SUPPORTED_CHAIN_IDS_SEPOLIA, L1TOKENS, AMOUNTS, L2TOKENS);
        vm.stopBroadcast();
    }
}
