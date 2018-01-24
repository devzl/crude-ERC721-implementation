pragma solidity ^0.4.18;

import './SafeMath.sol';

  	/**
	 * @title simpleERC721
	 *
	 * A crude, simple single file implementation of ERC721 standard
	 * @dev See https://github.com/ethereum/eips/issues/721
	 *
	 * Incomplete, the standard itself is not finalized yet (Before the issue 841, see: https://github.com/ethereum/EIPs/pull/841)
	*/

contract simpleERC721 {
    using SafeMath for uint256;

    // ------------- Variables 

    uint256 public totalSupply;

    mapping(uint => address) internal tokenIdToOwner;

    // ------------- Events 

    event Minted(address indexed _to, uint256 indexed _tokenId);

    // ------------- Modifier

    modifier onlyNonexistentToken(uint _tokenId) {
        require(tokenIdToOwner[_tokenId] == address(0));
        _;
    }

    // ------------- Functions 

    // @dev Anybody can create a token and give it to an owner
    // TODO, in the next version, add a Contract Owner 
    function mint(address _owner, uint256 _tokenId) public onlyNonexistentToken (_tokenId)
    {
    	tokenIdToOwner[_tokenId] = _owner;

        totalSupply = totalSupply.add(1);
        Minted(_owner, _tokenId);
    }

    // @dev Returns the address currently marked as the owner of _tokenID. 
    function ownerOf(uint256 _tokenId) public view returns (address _owner)
    {
        return tokenIdToOwner[_tokenId];
    }

    // @dev Get the total supply of token held by this contract. 
    function totalSupply() public view returns (uint256 _totalSupply)
    {
        return totalSupply;
    }

	// @dev Assigns the ownership of the NFT with ID _tokenId to _to
    function transfer(address _to, uint _tokenId) public onlyExtantToken(_tokenId)
    {
        require(ownerOf(_tokenId) == msg.sender);
        require(_to != address(0)); 

        _clearApprovalAndTransfer(msg.sender, _to, _tokenId);

        Approval(msg.sender, 0, _tokenId);
        Transfer(msg.sender, _to, _tokenId);
    }
}
