pragma solidity ^0.4.18;

import './SafeMath.sol';

  	/**
	 * @title simpleERC721
	 *
	 * A crude, single file implementation of ERC721 standard
	 * @dev See https://github.com/ethereum/eips/issues/721
	 *
	 * Incomplete, the standard itself is not finalized yet (Before the issue 841, see: https://github.com/ethereum/EIPs/pull/841)
	*/

contract simpleERC721 {
    using SafeMath for uint256;

    uint256 public totalSupply;

    mapping(uint => address) internal tokenIdToOwner;

    function totalSupply() public view returns (uint256 _totalSupply)
    {
        return totalSupply;
    }

    // @dev Returns the address currently marked as the owner of _tokenID. 
    function ownerOf(uint256 _tokenId) public view returns (address _owner)
    {
        return tokenIdToOwner[_tokenId];
    }


}
