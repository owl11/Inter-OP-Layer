//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.15;

import {ICrossDomainMessenger} from "../interfaces/ICrossDomainMessanger.sol";
import "@eth-optimism/contracts-bedrock/contracts/L1/L1StandardBridge.sol";
import {OPAddressRegistry_Testnet} from "./../Constants/OPAddressRegistry_testnet.sol";

// Custom errors are more gas-efficient than require with string messages
error NoChainIDs();
error NoETHSent();
error ArrSizeMissmatch();
error InvalidChainID();

contract MultiDomain_L1Bridge is OPAddressRegistry_Testnet {
    function quickDepositToAnyChain(uint256[] memory chainIDs) external payable {
        uint256 length = chainIDs.length;
        if (length == 0) revert NoChainIDs();
        if (msg.value == 0) revert NoETHSent();

        uint256 amountPerChain = msg.value / chainIDs.length;
        uint256 chainID;
        address STDBridge;

        for (uint256 i = 0; i < length;) {
            chainID = chainIDs[i];
            (, STDBridge,) = getAddresses(chainID);
            zeroAdressCheck(STDBridge);

            // Send the message using the cross-domain messenger
            L1StandardBridge(payable(STDBridge)).depositETHTo{value: amountPerChain}(msg.sender, 1000000, "");
            // Increment in unchecked block to save gas
            unchecked {
                ++i;
            }
        }
    }

    function DepositToMultipleRecipients(
        uint256[] memory chainIDs,
        address[] memory _recipient,
        uint256[] memory _amounts
    ) external payable {
        uint256 chainId_length = chainIDs.length;
        uint256 recipient_length = _recipient.length;
        uint256 amounts_length = _amounts.length;

        if (chainId_length != recipient_length || chainId_length != amounts_length) revert ArrSizeMissmatch();
        if (msg.value == 0) revert NoETHSent();
        // ArrSizeMissmatch
        uint256 amountPer_recipient;
        uint256 chainID;
        address STDBridge;

        for (uint256 i = 0; i < chainId_length;) {
            chainID = chainIDs[i];
            amountPer_recipient = _amounts[i];
            (, STDBridge,) = getAddresses(chainID);
            zeroAdressCheck(STDBridge);

            L1StandardBridge(payable(STDBridge)).depositETHTo{value: amountPer_recipient}(_recipient[i], 1000000, "");
            unchecked {
                ++i;
            }
        }
    }

    function DepositToManyChains(uint256[] memory chainIDs, address _recipient, uint256[] memory _amounts)
        external
        payable
    {
        uint256 chainId_length = chainIDs.length;
        uint256 amounts_length = _amounts.length;

        if (chainId_length != amounts_length) revert ArrSizeMissmatch();
        if (msg.value == 0) revert NoETHSent();
        // ArrSizeMissmatch
        uint256 amountPer_chain;
        uint256 chainID;
        address STDBridge;

        for (uint256 i = 0; i < chainId_length;) {
            chainID = chainIDs[i];
            amountPer_chain = _amounts[i];
            (, STDBridge,) = getAddresses(chainID);
            zeroAdressCheck(STDBridge);

            L1StandardBridge(payable(STDBridge)).depositETHTo{value: amountPer_chain}(_recipient, 1000000, "");
            unchecked {
                ++i;
            }
        }
    }

    function depositToAnyChain(uint256[] memory chainIDs, uint256[] memory _amounts) external payable {
        uint256 length = chainIDs.length;
        uint256 amounts_length = _amounts.length;

        if (length != amounts_length) revert ArrSizeMissmatch();
        // TODO # 1 : is this insfufficent checks? must we sum the amounts array?
        require(msg.value > _amounts[0], "Must send ETH to deposit"); //Not enough checkS

        uint256 amountPerChain;
        uint256 chainID;
        address STDBridge;

        for (uint256 i = 0; i < length; i++) {
            // TODO # 2 : must we check each transactions failure? in order to not halt execution if one paramter is invalid?
            chainID = chainIDs[i];
            amountPerChain = _amounts[i];
            (, STDBridge,) = getAddresses(chainID);
            zeroAdressCheck(STDBridge);
            // Send the message using the cross-domain messenger
            L1StandardBridge(payable(STDBridge)).depositETHTo{value: amountPerChain}(msg.sender, 1000000, "");
            unchecked {
                ++i;
            }
        }
    }

    function depositERC20ToAnyChain(
        uint256[] memory chainIDs,
        address[] memory L1Tokens,
        uint256[] memory amounts,
        address[] memory L2Tokens
    ) external {
        uint256 chainId_length = chainIDs.length;
        uint256 L1Tokens_length = L1Tokens.length;
        uint256 L2Tokens_length = L2Tokens.length;
        uint256 amounts_length = amounts.length;

        if (chainId_length != amounts_length || L1Tokens_length != L2Tokens_length || L1Tokens_length != chainId_length)
        {
            revert ArrSizeMissmatch();
        }
        uint256 amountPerChain;
        uint256 chainID;
        address STDBridge;
        address L1Token;
        address L2Token;

        for (uint256 i = 0; i < chainId_length; i++) {
            amountPerChain = amounts[i];
            chainID = chainIDs[i];
            L1Token = L1Tokens[i];
            L2Token = L2Tokens[i];
            (, STDBridge,) = getAddresses(chainID);
            zeroAdressCheck(STDBridge);
            // Send the message using the cross-domain messenger
            L1StandardBridge(payable(STDBridge)).depositERC20To(
                L1Token, L2Token, msg.sender, amountPerChain, 1000000, ""
            );
            unchecked {
                ++i;
            }
        }
    }


    function withdraw(address payable _to) public payable {
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool sent,) = _to.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    function zeroAdressCheck(address _address) private pure {
        assembly {
            if iszero(_address) {
                // revert with custom error
                mstore(0x00, 0x8aca9d85) // selector for InvalidChainID()
                revert(0x00, 0x04)
            }
        }
    }
}
