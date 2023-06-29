//SPDX-License-Identifier:UNLICENSED

pragma solidity ^0.8.0;
import "erc20.sol";
import "erc721.sol";

contract TokenIntegration {
    MyERC721 public erc721Contract;
    MyERC20 public erc20Contract;

    constructor(address erc721Address, address erc20Address) {
        erc721Contract = MyERC721(erc721Address);
        erc20Contract = MyERC20(erc20Address);
    }

    function createToken() external {
        uint256 tokenId = erc721Contract.createToken(msg.sender);
        uint256 erc20Amount = 1000;
        erc721Contract.associateERC20(tokenId, erc20Amount);
    }

    function transferERC721(address to, uint256 tokenId) external {
        erc721Contract.transferFrom(msg.sender, to, tokenId);
    }

    function transferERC20(address to, uint256 amount) external {
        erc20Contract.transfer(to, amount);
    }
}

