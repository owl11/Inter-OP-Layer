// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

// import { ICrossDomainMessenger } from "@eth-optimism/contracts/libraries/bridge/ICrossDomainMessenger.sol";
// import { CREATE2Deployer } from "./CREATE2Deployer.sol";
import { OPAddressRegistry_Testnet, OP_CHAIN_IDS_TESTNETS } from "../Libraries/OPAddressRegistry_testnet.sol";
import {L1CrossDomainMessenger} from "@eth-optimism/contracts-bedrock/contracts/L1/L1CrossDomainMessenger.sol";
import {Greeter} from "./Greeter.sol";
contract L1ContractDeployer is OPAddressRegistry_Testnet {
    error insfuccientGasTodeploy();

    function estimateGas(bytes memory _creationCode, uint256 _chainID) public view returns (uint32 minGas) {
        bytes memory message =
            abi.encodeWithSignature("deployContract(bytes,bytes32)", _creationCode, bytes32(block.difficulty));
        address messsanger;
        (messsanger,,) = getAddresses(_chainID);
        minGas = uint32(L1CrossDomainMessenger((messsanger)).baseGas(message, 1000000));
    }

    function deployOnL2(uint256 _chainID, bytes memory _creationCode, address _l2Deployer) external payable {
        bytes32 _salt = bytes32(block.difficulty);
        address messsanger;

        // Prepare the message to send to the L2 deployer
        bytes memory message = abi.encodeWithSignature("deployContract(bytes,bytes32)", _creationCode, _salt);
        (messsanger,,) = getAddresses(_chainID);
        // Send the message using the cross-domain messenger
        L1CrossDomainMessenger(payable(messsanger)).sendMessage{value: 2_200_000}(_l2Deployer, message, estimateGas(_creationCode, _chainID));
    }
    //Example contract of retriving a creationCode 
    function getCreationCode() public pure returns (bytes memory) {
        return type(Greeter).creationCode;
    }
}
