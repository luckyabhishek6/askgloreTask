//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyERC721 is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    mapping(uint256 => uint256) private _tokenToERC20;

    constructor() ERC721("MyERC721", "M721") {}

    function createToken(address recipient) external returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        return newItemId;
    }

    function associateERC20(uint256 tokenId, uint256 erc20Amount) external {
        require(_exists(tokenId), "Token does not exist");
        _tokenToERC20[tokenId] = erc20Amount;
    }

    function getTokenERC20Amount(uint256 tokenId) external view returns (uint256) {
        require(_exists(tokenId), "Token does not exist");
        return _tokenToERC20[tokenId];
    }

    function transferFrom(address from, address to, uint256 tokenId) public override {
        super.transferFrom(from, to, tokenId);
        // Transfer associated ERC20 tokens here
    }
}
