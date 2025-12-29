// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title Eventchain
 * @dev ERC-721 NFT contract with deposit, withdraw, and balance functions
 * @author sshekhar563
 */
contract HeroOfTheVillage is ERC721, Ownable {
    
    constructor() ERC721("HeroOfTheVillage", "HOTV") Ownable(msg.sender) {}

    /**
     * @dev Mints a new NFT to the specified address
     * @param to The address that will receive the minted NFT
     * @param tokenId The token ID to mint
     */
    function deposit(address to, uint256 tokenId) external onlyOwner {
        _mint(to, tokenId);
    }

    /**
     * @dev Transfers an NFT from the caller to the contract owner (withdraw)
     * @param tokenId The token ID to withdraw/transfer
     */
    function withdraw(uint256 tokenId) external {
        require(ownerOf(tokenId) == msg.sender, "Not the token owner");
        _transfer(msg.sender, owner(), tokenId);
    }

    /**
     * @dev Returns the number of NFTs owned by an address
     * @param ownerAddress The address to query
     * @return The number of NFTs owned
     */
    function getBalance(address ownerAddress) external view returns (uint256) {
        return balanceOf(ownerAddress);
    }
}
