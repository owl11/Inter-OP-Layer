// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ICrossDomainMessenger} from "../interfaces/ICrossDomainMessanger.sol";
import {OPAddressRegistry_Testnet} from "./../Constants/OPAddressRegistry_testnet.sol";

contract multiDomainMessenger is OPAddressRegistry_Testnet {
    /// @notice Send a greeting message to the specified target chain
    /// @param _greeting The greeting message
    /// @param _targetChainID The ID of the target chain
    function setGreeting(string calldata _greeting, uint256 _targetChainID, address _targetAddress) public {
        // Get the appropriate cross-domain messenger and target address
        (address crossDomainMessengerAddr,,) = getAddresses(_targetChainID);

        require(crossDomainMessengerAddr != address(0), "Invalid chain ID");

        // Prepare the message to send
        bytes memory message = abi.encodeWithSignature("setGreeting(string,address)", _greeting, msg.sender);

        // Send the message using the cross-domain messenger
        ICrossDomainMessenger(crossDomainMessengerAddr).sendMessage(
            _targetAddress,
            message,
            1000000 // Gas limit, adjust as needed
        );
    }

    function sendCrossChainMessage(bytes calldata _data, uint256 _targetChainID, address _targetAddress) public {
        (address crossDomainMessengerAddr,,) = getAddresses(_targetChainID);
        require(crossDomainMessengerAddr != address(0), "Invalid chain ID");
        // bytes memory message = abi.encodeWithSignature("setGreeting(string,address)", _greeting, msg.sender);

        ICrossDomainMessenger(crossDomainMessengerAddr).sendMessage(
            _targetAddress,
            _data,
            1000000 // Gas limit, adjust as needed
        );
    }

    function encodeCallAndParams(string calldata _funcCall, bytes calldata _params)
        public
        pure
        returns (bytes memory message)
    {
        //Params must be provided in said format, example func call setGreeting() must be provided with the params field, and the data that will populate said field
        //E.G ("setGreeting(string,address)", _greeting, msg.sender)
        // bytes memory message = abi.encodeWithSignature("setGreeting(string,address)", _greeting, msg.sender);
        message = abi.encodeWithSignature(_funcCall, _params);
    }
}
