// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./TokenBank.sol";

// token::0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// bankV2::0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2

// 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db

contract TokenBankV2 is TokenBank {
    IERC20 erc20Token;
    constructor(IERC20 erc20Addr) {
        erc20Token = IERC20(erc20Addr);
    }
    function tokensReceived(address from,uint256 amount) public {
        require(msg.sender == address(erc20Token) , "you isn't token owner");
        balances[from] += amount;
    }
}