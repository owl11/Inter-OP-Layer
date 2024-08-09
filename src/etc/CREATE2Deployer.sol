// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ICrossDomainMessenger} from "../interfaces/ICrossDomainMessanger.sol";
import {OPAddressRegistry_Testnet} from "./../Constants/OPAddressRegistry_testnet.sol";
import {L1ContractDeployer} from "./L1ContractDeployer.sol";
import {Predeploys} from "@eth-optimism/contracts-bedrock/contracts/libraries/Predeploys.sol";

contract CREATE2Deployer is OPAddressRegistry_Testnet {
    event ContractDeployed(address indexed contractAddress, bytes32 indexed salt);

    error NotAllowed();
    error deploymentFailed();

    L1ContractDeployer deployer;
    uint256 public immutable CHAIN_ID;
    address[] public deployedAddresses;

    constructor(address _L1Deployer) {
        CHAIN_ID = block.chainid;
        deployer = L1ContractDeployer(_L1Deployer);
    }

    function deployContract(bytes memory _bytecode, bytes32 _salt) public returns (address, bool) {
        if (getXorig() != address(deployer)) {
            revert NotAllowed();
        }
        // Deploy the contract using CREATE2
        address contractAddress;
        assembly {
            contractAddress := create2(0, add(_bytecode, 0x20), mload(_bytecode), _salt)
        }

        if (contractAddress == address(0)) {
            revert deploymentFailed();
        }

        emit ContractDeployed(contractAddress, _salt);
        deployedAddresses.push(contractAddress);
        return (contractAddress, true);
    }

    function getContractAddress(bytes memory _bytecode, bytes32 _salt) public view returns (address) {
        return address(
            uint160(uint256(keccak256(abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(_bytecode)))))
        );
    }

    function getXorig() private view returns (address) {
        address cdmAddr = address(0);
        // L2 (same address on every network)
        if (isOPAlligned(CHAIN_ID)) {
            cdmAddr = Predeploys.L2_CROSS_DOMAIN_MESSENGER;
        }

        // If this isn't a cross domain message
        if (msg.sender != cdmAddr) {
            return address(0);
        }

        // If it is a cross domain message, find out where it is from
        return ICrossDomainMessenger(cdmAddr).xDomainMessageSender();
    } // getXorig()

    function deployContractTester(bytes memory _bytecode, bytes32 _salt) public returns (address, bool) {
        // Deploy the contract using CREATE2
        address contractAddress;
        assembly {
            contractAddress := create2(0, add(_bytecode, 0x20), mload(_bytecode), _salt)
        }

        if (contractAddress == address(0)) {
            revert deploymentFailed();
        }

        emit ContractDeployed(contractAddress, _salt);
        deployedAddresses.push(contractAddress);
        return (contractAddress, true);
    }
}
