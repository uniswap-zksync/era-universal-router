// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.15;

import "./MockERC721.sol";


contract MockSeaport {



    struct OfferItem {
        ItemType itemType;
        address token;
        uint256 identifierOrCriteria;
        uint256 startAmount;
        uint256 endAmount;
    }


    struct ConsiderationItem {
        ItemType itemType;
        address token;
        uint256 identifierOrCriteria;
        uint256 startAmount;
        uint256 endAmount;
        address payable recipient;
    }

    struct Order {
        OrderParameters parameters;
        bytes signature;
    
    }
    struct OrderParameters {
        address offerer;
        address zone;
        OfferItem[] offer;
        ConsiderationItem[] consideration;
        OrderType orderType;
        uint256 startTime;
        uint256 endTime;
        bytes32 zoneHash;
        uint256 salt;
        bytes32 conduitKey;
        uint256 totalOriginalConsiderationItems;
    }

    struct AdvancedOrder {
        OrderParameters parameters;
        uint120 numerator;
        uint120 denominator;
        bytes signature;
        bytes extraData;
    }

    struct CriteriaResolver {
        uint256 orderIndex;
        Side side;
        uint256 index;
        uint256 identifier;
        bytes32[] criteriaProof;
    }
    
    enum ItemType{
        NATIVE,
        ERC20,
        ERC721,
        ERC1155,
        ERC721_WITH_CRITERIA,
        ERC1155_WITH_CRITERIA
    }
    enum OrderType{
        FULL_OPEN,
        PARTIAL_OPEN,
        FULL_RESTRICTED,
        PARTIAL_RESTRICTED,
        CONTRACT
    }
    enum Side {
        OFFER,
        CONSIDERATION
    }

    address nftAddress;
    address alice;


    constructor(address _nftAddress, address _alice)  {
        nftAddress = _nftAddress;
        alice = _alice;
    }

    function fulfillOrder(Order memory order, bytes32 fulfillerConduitKey) external payable returns (bool success, bytes memory output) {
       bytes memory _output = bytes('0x8baa579f');
       bool _success = false;
       
       MockERC721(nftAddress).mint(alice, 1);
       MockERC721(nftAddress).mint(alice, 2);
       require(_success, '0x8baa579f');
       return (false, _output);
    }

    function fulfillAdvancedOrder(AdvancedOrder memory advancedOrder, CriteriaResolver[] memory criteriaResolvers, bytes32 fulfillerConduitKey, address recipient) external payable returns (bool fulfilled){
        return true;
    }
}
