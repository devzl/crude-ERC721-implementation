pragma solidity ^0.4.18;

    /**
     * @title SafeMath
     * @dev Math operations with safety checks that throw on error
     */

library SafeMath {
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) {
      return 0;
    }
    uint256 c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return c;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    assert(c >= a);
    return c;
  }
}

  	/**
	 * @title SimpleERC721
	 *
	 * A crude, simple single file implementation of ERC721 standard
	 * @dev See https://github.com/ethereum/eips/issues/721
	 *
	 * Incomplete, the standard itself is not finalized yet (Done before the issue 841, see: https://github.com/ethereum/EIPs/pull/841)
	*/

contract SimpleERC721 {
    using SafeMath for uint256;

    // ------------- Variables 

    uint256 public totalSupply;

    mapping(uint => address) internal tokenIdToOwner;
    mapping(address => uint[]) internal ownerToTokensOwned;
    mapping(uint => uint) internal tokenIdToOwnerArrayIndex;

    // ------------- Events 

    event Minted(address indexed _to, uint256 indexed _tokenId);
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);

    // ------------- Modifier

    modifier onlyNonexistentToken(uint _tokenId) {
        require(tokenIdToOwner[_tokenId] == address(0));
        _;
    }

    modifier onlyExtantToken(uint _tokenId) {
        require(ownerOf(_tokenId) != address(0));
        _;
    }

    // ------------- Functions 

    // @dev Anybody can create a token and give it to an owner
    // TODO, in the next version, add a Contract Owner 
    function mint(address _owner, uint256 _tokenId) public onlyNonexistentToken (_tokenId)
    {
    	_setTokenOwner(_tokenId, _owner);
        _addTokenToOwnersList(_owner, _tokenId);

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
    function transfer(address _to, uint _tokenId) public onlyExtantToken (_tokenId)
    {
        require(ownerOf(_tokenId) == msg.sender);
        require(_to != address(0)); 

        tokenIdToOwner[_tokenId] = _to;

        Transfer(msg.sender, _to, _tokenId);
    }

    function balanceOf(address _owner) public view returns (uint _balance)
    {
        return ownerToTokensOwned[_owner].length;
    }

    // ---------------------------- Internal, helper functions

    function _setTokenOwner(uint _tokenId, address _owner) internal
    {
        tokenIdToOwner[_tokenId] = _owner;
    }

    function _addTokenToOwnersList(address _owner, uint _tokenId) internal
    {
        ownerToTokensOwned[_owner].push(_tokenId);
        tokenIdToOwnerArrayIndex[_tokenId] = ownerToTokensOwned[_owner].length - 1;
    }
}