// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// import "./Bank.sol";
import "./IBank.sol";

contract Admin {
    address admin;
    constructor() payable  {
        admin = msg.sender;
    }

    modifier onlyOwner {
        require(admin == msg.sender, "only owner can be opeate");
        _;
    }

    function adminWithdraw(IBank Bank) external onlyOwner {
        Bank.withdraw();
    }
    receive() external payable { }

}