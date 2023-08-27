// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MultiNFT is ERC721, Ownable {
    struct NFT {
        uint256 tokenId;
        string tokenURI;
    }

    struct Collection {
        string name;
        uint256[] nftIds;
    }

    NFT[] public nfts;
    Collection[] public collections;

    constructor() ERC721("MultiNFT", "MNFT") {}

    function mintNFT(address recipient, string memory tokenURI) public onlyOwner {
        uint256 tokenId = totalSupply();
        _mint(recipient, tokenId);
        _setTokenURI(tokenId, tokenURI);

        nfts.push(NFT(tokenId, tokenURI));
    }

    function createCollection(string memory name, uint256[] memory nftIds) public onlyOwner {
        collections.push(Collection(name, nftIds));
    }

    function getCollectionCount() public view returns (uint256) {
        return collections.length;
    }

    function getCollection(uint256 index) public view returns (string memory, uint256[] memory) {
        require(index < collections.length, "Invalid index");
        Collection storage collection = collections[index];
        return (collection.name, collection.nftIds);
    }
}
