pragma solidity ^0.5.0;

import "../gateway/EIP20CoGateway.sol";

/**
 * @title TestEIP20CoGateway contract.
 *
 * @notice Used for test only.
 */
contract TestEIP20CoGateway is EIP20CoGateway {

    /* Constructor */

    /**
     * @notice Initialise the contract by providing the Gateway contract
     *         address for which the CoGateway will enable facilitation of
     *         minting and redeeming.
     *
     * @param _valueToken The value token contract address.
     * @param _utilityToken The utility token address that will be used for
     *                      minting the utility token.
     * @param _core Core contract address.
     * @param _bounty The amount that facilitator will stakes to initiate the
     *                staking process.
     * @param _membersManager Organisation address.
     * @param _gateway Gateway contract address.
     */
    constructor(
        address _valueToken,
        address _utilityToken,
        CoreInterface _core,
        uint256 _bounty,
        IsMemberInterface _membersManager,
        address _gateway
    )
    EIP20CoGateway(
        _valueToken,
        _utilityToken,
        _core,
        _bounty,
        _membersManager,
        _gateway
    )
    public
    {

    }


    /* Public Functions */

    /**
     * @notice It is used to set the messagehash.
     *
     * @dev It is for test purposes only.
     *
     * @param _intentHash Intent hash.
     * @param _stakerNonce Nonce of the staker address.
     * @param _gasPrice Gas price that staker is ready to pay to get the stake
     *                  and mint process done.
     * @param _gasLimit Gas limit that staker is ready to pay.
     * @param _hashLock Hash Lock provided by the facilitator.
     * @param _staker Staker address.
     *
     * @return messageHash_ Hash unique for every request.
     */
    function setMessage(
        bytes32 _intentHash,
        uint256 _stakerNonce,
        uint256 _gasPrice,
        uint256 _gasLimit,
        bytes32 _hashLock,
        address _staker
    )
        public
        returns (bytes32 messageHash_)
    {

        messageHash_ = MessageBus.messageDigest(
            STAKE_TYPEHASH,
            _intentHash,
            _stakerNonce,
            _gasPrice,
            _gasLimit
        );

        messages[messageHash_] = getMessage(
            _staker,
            _stakerNonce,
            _gasPrice,
            _gasLimit,
            _intentHash,
            _hashLock
        );

        return messageHash_;

    }

    /**
     * @notice It sets the mints mapping with respect to the messageHash.
     *
     * @dev It is for test purposes only.
     *
     * @param _messageHash Hash for which mints mapping is updated.
     * @param _beneficiary Beneficiary  Address to which the utility tokens
     *                     will be transferred after minting.
     * @param _amount Total amount for which the stake was initiated. The
     *                reward amount is deducted from the total amount and
     *                is given to the facilitator.
     */
    function setMints(
        bytes32 _messageHash,
        address _beneficiary,
        uint256 _amount
    )
        public
    {
        mints[_messageHash] = Mint({
            amount : _amount,
            beneficiary : _beneficiary
        });
    }

    /**
     * @notice It sets the status of inbox to Declared.
     *
     * @dev It is for test purposes only.
     *
     * @param _messageHash Hash for which status is set to Declared.
     */
    function setInboxStatus(bytes32 _messageHash) public {

        messageBox.inbox[_messageHash] = MessageBus.MessageStatus.Declared;

    }

}