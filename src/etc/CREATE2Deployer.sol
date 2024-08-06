// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ICrossDomainMessenger} from "../interfaces/ICrossDomainMessanger.sol";

contract CREATE2Deployer {
    event ContractDeployed(address indexed contractAddress, bytes32 indexed salt);

    function deployContract(bytes memory _bytecode, uint256 _salt) public returns (address) {
        // Deploy the contract using CREATE2
        address contractAddress;
        bytes32 salt = keccak256(abi.encode(_salt));
        assembly {
            contractAddress := create2(0, add(_bytecode, 0x20), mload(_bytecode), salt)
        }

        require(contractAddress != address(0), "Contract deployment failed");

        emit ContractDeployed(contractAddress, salt);
        return contractAddress;
    }

    function getContractAddress(bytes memory _bytecode, bytes32 _salt) public view returns (address) {
        return address(
            uint160(uint256(keccak256(abi.encodePacked(bytes1(0xff), address(this), _salt, keccak256(_bytecode)))))
        );
    }
}
//     function deployContract(bytes memory _bytecode, bytes memory _constructorArgs, bytes32 _salt) external returns (address) {
//         // Combine the bytecode and constructor arguments
//         bytes memory bytecodeWithArgs = abi.encodePacked(_bytecode, _constructorArgs);

//         // Deploy the contract using CREATE2
//         address contractAddress;
//         assembly {
//             contractAddress := create2(0, add(bytecodeWithArgs, 0x20), mload(bytecodeWithArgs), _salt)
//         }

//         require(contractAddress != address(0), "Contract deployment failed");

//         emit ContractDeployed(contractAddress, _salt);
//         return contractAddress;
//     }

//     function getContractAddress(bytes memory _bytecode, bytes memory _constructorArgs, bytes32 _salt) external view returns (address) {
//         bytes memory bytecodeWithArgs = abi.encodePacked(_bytecode, _constructorArgs);
//         return address(uint160(uint256(keccak256(abi.encodePacked(
//             bytes1(0xff),
//             address(this),
//             _salt,
//             keccak256(bytecodeWithArgs)
//         )))));
//     }
// }
