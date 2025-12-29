// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract HeroOfTheVillage is ERC721, Ownable {
    uint256 private _nextTokenId;
    
    mapping(address => uint256) public nftBalances;

    constructor() ERC721("Hero of the Village", "HOTV") Ownable(msg.sender) {}

    function deposit(address to, uint256 tokenId) external onlyOwner {
        _mint(to, tokenId);
        nftBalances[to]++;
    }

    function withdraw(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "Not the owner");
        _burn(tokenId);
        nftBalances[msg.sender]--;
    }

    function getBalance(address owner) external view returns (uint256) {
        return balanceOf(owner);
    }

    function _update(address to, uint256 tokenId, address auth) internal override returns (address) {
        address from = _ownerOf(tokenId);
        nftBalances[from]--;
        nftBalances[to]++;
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value) internal virtual override {
        super._increaseBalance(account, value);
    }
}

