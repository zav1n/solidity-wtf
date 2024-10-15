pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

// 0x09532E7cB0E2E2954b503707aeB1Ae2D20f19299
// 区块链查看部署的合约  https://sepolia.etherscan.io/tx/0x2ba47cd793ddfcd92f9c4e024e1f4140d9dbd571aa5142ea14b0c9569d987eeb
// mint(0xeEE4739AD49c232Ef2Bb968fC2346Edbe03c8888, ipfs://QmYGrU1yeF3stANG7WgixpfLpMywq4ej3m5zKRW1mGbM67)
// https://testnets.opensea.io/zh-CN/assets/sepolia/0x09532e7cb0e2e2954b503707aeb1ae2d20f19299/1

contract DecertERC72 is ERC721URIStorage {
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