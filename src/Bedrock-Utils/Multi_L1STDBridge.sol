//SPDX-License-Identifier: Unlicense
// This contracts runs on L1, and controls a Greeter on L2.
// The addresses are specific to Optimistic Goerli.
pragma solidity ^0.8.15;

import {ICrossDomainMessenger} from "../interfaces/ICrossDomainMessanger.sol";
import "@eth-optimism/contracts-bedrock/contracts/L1/L1StandardBridge.sol";
import {OPAddressRegistry_Testnet} from "./../Libraries/OPAddressRegistry_testnet.sol";

contract FromL1_ControlL2Greeter is OPAddressRegistry_Testnet {
    function quickDepositToAnyChain(uint256[] memory chainIDs) external payable {
        require(chainIDs.length > 0, "No chain IDs provided");
        require(msg.value > 0, "Must send ETH to deposit");

        uint256 amountPerChain = msg.value / chainIDs.length;
        uint256 chainID;
        address STDBridge;

        for (uint256 i = 0; i < chainIDs.length; i++) {
            chainID = chainIDs[i];
            (, STDBridge,) = getAddresses(chainID);
            require(STDBridge != address(0), "Invalid chain ID");

            // Send the message using the cross-domain messenger
            L1StandardBridge(payable(STDBridge)).depositETHTo{value: amountPerChain}(msg.sender, 1000000, "");
        }
    }

    function depositToAnyChain(uint256[] memory chainIDs, uint256[] memory _amounts) external payable {
        require(chainIDs.length > 0, "No chain IDs provided");
        require(chainIDs.length == _amounts.length, "missmatch, chainID and amounts are inequal");
        // TODO # 1 : is this insfufficent checks? must we sum the amounts array?
        require(msg.value > _amounts[1], "Must send ETH to deposit"); //Not enough checkS

        uint256 amountPerChain;
        uint256 chainID;
        address STDBridge;

        for (uint256 i = 0; i < chainIDs.length; i++) {
            // TODO # 2 : must we check each transactions failure? in order to not halt execution if one paramter is invalid?
            chainID = chainIDs[i];
            amountPerChain = _amounts[i];
            (, STDBridge,) = getAddresses(chainID);
            require(STDBridge != address(0), "Invalid chain ID");

            // Send the message using the cross-domain messenger
            L1StandardBridge(payable(STDBridge)).depositETHTo{value: amountPerChain}(msg.sender, 1000000, "");
        }
    }

    function depositERC20ToAnyChain(
        uint256[] memory chainIDs,
        address[] memory L1Tokens,
        uint256[] memory amounts,
        address[] memory L2Tokens
    ) external {
        require(chainIDs.length > 0, "No chain IDs provided");

        uint256 amountPerChain;
        uint256 chainID;
        address STDBridge;
        address L1Token;
        address L2Token;

        for (uint256 i = 0; i < chainIDs.length; i++) {
            amountPerChain = amounts[i];
            chainID = chainIDs[i];
            L1Token = L1Tokens[i];
            L2Token = L2Tokens[i];
            (, STDBridge,) = getAddresses(chainID);
            require(STDBridge != address(0), "Invalid chain ID");

            // Send the message using the cross-domain messenger
            L1StandardBridge(payable(STDBridge)).depositERC20To(
                L1Token, L2Token, msg.sender, amountPerChain, 1000000, ""
            );
        }
    }

    function getXorig() public view returns (address) {
        // Get the cross domain messenger's address each time.
        // This is less resource intensive than writing to storage.
        address cdmAddr = address(0);

        // Mainnet
        if (block.chainid == 1) {
            cdmAddr = 0x25ace71c97B33Cc4729CF772ae268934F7ab5fA1;
        }

        // Seploia
        if (block.chainid == 11155111) {
            cdmAddr = 0x5086d1eEF304eb5284A0f6720f79403b4e9bE294;
        }

        // L2's (same address on every network)
        if (block.chainid == 10 || block.chainid == 11155420 || block.chainid == 84532 || block.chainid == 999999999) {
            cdmAddr = 0x4200000000000000000000000000000000000007;
        }

        // If this isn't a cross domain message
        if (msg.sender != cdmAddr) return address(0);

        // If it is a cross domain message, find out where it is from
        return ICrossDomainMessenger(cdmAddr).xDomainMessageSender();
    }

    function withdraw(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent,) = _to.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }
}
