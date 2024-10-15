// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenBank {
    IERC20 public token;
    mapping(address => uint256) balances;

    constructor(address _tokenAddress) {
        token = IERC20(_tokenAddress);
    }

    function deposit(uint256 amount) public {
        require(amount > 0, "amount must be more than 0");
        token.transferFrom(msg.sender, address(this), amount);
        balances[msg.sender] += amount;
    }

    function widthdraw() public {
        uint256 balance = balances[msg.sender];
        require(balance > 0,"no balance can withdraw");
        token.transfer(msg.sender, balance);
        balances[msg.sender] = 0;
    }

    function getBalance(address addr) public view returns (uint256) {
        return balances[addr];
    }
}