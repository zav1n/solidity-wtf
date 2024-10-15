pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract MyERC721 is ERC721URIStorage {
using Counters for Counters.Counter;
Counters.Counter private _tokenIds;
// 0x09532E7cB0E2E2954b503707aeB1Ae2D20f19299
constructor() ERC721(unicode"suzefeng", "SZF") {}

    function mint(address student, string memory tokenURI) public returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(student, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }
}