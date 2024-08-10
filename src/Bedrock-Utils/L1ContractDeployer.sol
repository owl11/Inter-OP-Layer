// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

import {OPAddressRegistry_Testnet, OP_CHAIN_IDS_TESTNETS} from "../Constants/OPAddressRegistry_testnet.sol";
import {ICrossDomainMessenger} from "../interfaces/ICrossDomainMessanger.sol";
import {Greeter} from "../etc/Greeter.sol";
import {CREATE2Deployer} from "./CREATE2Deployer.sol";

contract L1ContractDeployer is OPAddressRegistry_Testnet {
    uint32 constant TEN_THOUSAND = 10_000;
    uint32 constant ONE_MILLION = 1_000_000;
    uint32 constant THREE_MILLION = 3_000_000;
    uint32 constant MAX = type(uint32).max;

    error insfuccientGasTodeploy();

    function deployOnL2(uint256 _chainID, bytes memory _creationCode, uint32 _minGasLimit, uint256 _salt)
        external
        payable
        returns (bool success, bytes memory returnData)
    {
        if (_minGasLimit < TEN_THOUSAND) {
            _minGasLimit = 1_000_000; //min gasLimit will be set to 1 million, however it may not be enough to send messange and deploy on the other chain
        }
        bytes32 salt = keccak256(abi.encode(_salt));
        address messsanger;

        // Prepare the message to send to the L2 deployer
        bytes memory message = abi.encodeWithSignature("deployContract(bytes,bytes32)", _creationCode, salt);
        (messsanger,,) = getAddresses(_chainID);
        // Send the message using the cross-domain messenger
        ICrossDomainMessenger(payable(messsanger)).sendMessage(
            OPAddressRegistry_Testnet.C2DEPLOYER, message, _minGasLimit
        );
        return (success, returnData);
    }

    function deploToManyL2s(uint256[] memory chainIDs, bytes memory _creationCode, uint32 _minGasLimit, uint256 _salt)
        external
        payable
        returns (bool success)
    {
        if (_minGasLimit < TEN_THOUSAND) {
            _minGasLimit = 1_000_000;
            //min gasLimit will be set to 1 million, however it may not be enough to send messange and deploy on the other chain
        }
        bytes32 salt = keccak256(abi.encode(_salt));
        address messsanger;
        uint256 chainID;

        // Prepare the message to send to the L2 deployer
        bytes memory message = abi.encodeWithSignature("deployContract(bytes,bytes32)", _creationCode, salt);
        uint256 length = chainIDs.length;
        // address _l2Deployer;
        for (uint256 i = 0; i < length;) {
            chainID = chainIDs[i];

            (messsanger,,) = getAddresses(chainID);
            // Using assembly for the address check
            assembly {
                if iszero(messsanger) {
                    // revert with custom error
                    mstore(0x00, 0x8aca9d85) // selector for InvalidChainID()
                    revert(0x00, 0x04)
                }
            }
            // Send the message using the cross-domain messenger
            ICrossDomainMessenger(payable(messsanger)).sendMessage(
                OPAddressRegistry_Testnet.C2DEPLOYER, message, _minGasLimit
            );
            // Increment in unchecked block to save gas
            unchecked {
                ++i;
            }

            // Send the message using the cross-domain messenger
            return (success);
        }
    }
    //DO NOT USE, function used to estimate gas gost of deploying a create2 contract
    // inspired and modified from the safe-contracts SimulateTxAccessor.sol
    //https://github.com/safe-global/safe-smart-account/blob/main/contracts/accessors/SimulateTxAccessor.sol
    //Only use this locally, to estimate how much gas you'd need to deploy, you must also account for the gas relay within the CrossDomain messanger itself

    function simulateCreate2(bytes memory _creationCode, uint256 _salt)
        external
        returns (uint256 estimate, bool success, bytes memory returnData)
    {
        uint256 startGas = gasleft();
        bytes32 salt = keccak256(abi.encode(_salt));

        // Simulate the deployment using CREATE2
        address deployedAddress;
        assembly {
            // Calculate the address of the new contract
            let bytecode := add(_creationCode, 0x20) // Skip the length prefix
            let bytecodeSize := mload(_creationCode)
            deployedAddress := create2(0, bytecode, bytecodeSize, salt)
        }

        // Check if the deployment was successful
        success = (deployedAddress != address(0));

        // Estimate gas used
        estimate = startGas - gasleft();

        // Prepare return data
        if (success) {
            // If successful, you might want to call a function on the deployed contract
            // For example, you could call an initialization function here if needed.
            // This is optional and depends on your contract's design.
            returnData = ""; // You can set this to the actual return data if needed
        } else {
            returnData = ""; // No return data if deployment failed
        }

        /* solhint-disable no-inline-assembly */
        /// @solidity memory-safe-assembly
        assembly {
            // Load free memory location
            let ptr := mload(0x40)
            // We allocate memory for the return data by setting the free memory location to
            // current free memory location + data size + 32 bytes for data size value
            mstore(0x40, add(ptr, add(returndatasize(), 0x20)))
            // Store the size
            mstore(ptr, returndatasize())
            // Store the data
            returndatacopy(add(ptr, 0x20), 0, returndatasize())
            // Point the return data to the correct memory location
            returnData := ptr
        }
        /* solhint-enable no-inline-assembly */
    }

    function getCreationCode() public pure returns (bytes memory) {
        return type(Greeter).creationCode;
    }

    //placeholder function made for testing within the foundry test suite, comment out if delpoyed
    function deployOnL2ForTest(bytes memory _creationCode, address _l2Deployer, uint256 _salt)
        external
        payable
        returns (bool success, bytes memory returnData)
    {
        bytes32 salt = keccak256(abi.encode(_salt));
        bytes memory message = abi.encodeWithSignature("deployContractTester(bytes,bytes32)", _creationCode, salt);
        (success, returnData) = _l2Deployer.call{value: msg.value}(message);
        return (success, returnData);
    }
}
