// SPDX-License-Identifier: MIT
pragma solidity 0.8.15;

import {Predeploys} from "@eth-optimism/contracts-bedrock/contracts/libraries/Predeploys.sol";
import {OptimismPortal} from "@eth-optimism/contracts-bedrock/contracts/L1/OptimismPortal.sol";
import {Semver} from "@eth-optimism/contracts-bedrock/contracts/universal/Semver.sol";

import {CrossDomainMessenger} from "../../Bedrock-Universals-Forks/CrossDomainMessengerModified.sol";
import {OPAddressRegistry_Testnet} from "../../Libraries/OPAddressRegistry_testnet.sol";

/**
 * @custom:proxied
 * @title L1CrossDomainMessenger
 * @notice The L1CrossDomainMessenger is a message passing interface between L1 and L2 responsible
 *         for sending and receiving data on the L1 side. Users are encouraged to use this
 *         interface instead of interacting with lower-level contracts directly.
 */
contract L1MultiDomainMessanger is CrossDomainMessenger, Semver {
    /**
     * @notice Address of the OptimismPortal.
     */
    OptimismPortal PORTAL;

    /**
     * @custom:semver 1.4.0
     *
     * @notice forked from L1 crossDomainMessanger, this implementation is meant to handle multiple OP Portals
     */
    constructor()
        Semver(1, 5, 0) // 1.X.0?
        CrossDomainMessenger(Predeploys.L2_CROSS_DOMAIN_MESSENGER)
    {
        // PORTAL = _portal;
        initialize();
    }

    /**
     * @notice Initializer.
     */
    function initialize() public initializer {
        __CrossDomainMessenger_init();
    }

    /**
     * @inheritdoc CrossDomainMessenger
     */
    function _sendMessage(uint256 _targetChainID, address _to, uint64 _gasLimit, uint256 _value, bytes memory _data)
        internal
        override
    {
        (,, address OPPortal) = getAddresses(_targetChainID);
        require(OPPortal != address(0), "Invalid chain ID");
        OptimismPortal(payable(OPPortal)).depositTransaction{value: _value}(_to, _value, _gasLimit, false, _data);
    }

    /**
     * @inheritdoc CrossDomainMessenger
     */
    function _isOtherMessenger(uint256 _targetChainID) internal view override returns (bool) {
        (address crossDomMsger,, address OPPortal) = getAddresses(_targetChainID);
        return msg.sender == OPPortal
            && OptimismPortal(payable(OPPortal)).l2Sender() == CrossDomainMessenger(crossDomMsger).OTHER_MESSENGER();
    }

    /**
     * @inheritdoc CrossDomainMessenger
     */
    function _isUnsafeTarget(address _target, uint256 _targetChainID) internal view override returns (bool) {
        (,, address OPPortal) = getAddresses(_targetChainID);
        return _target == address(this) || _target == OPPortal;
    }
}
