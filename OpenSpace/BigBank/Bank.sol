// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./IBank.sol";

contract Bank is IBank {
    address public admin;
    mapping(address => uint256) public balances;
    address[] public topList;

    // struct Account {
    //     address addr;
    //     uint256 balance;
    // }

    // event Deposit(address, uint);
    // event Withdraw(address, uint256);

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin {
        require(admin == msg.sender, "only admin operate");
        _;
    }

    // 存款
    function deposit() public payable virtual {
        require(msg.value > 0, "amount can't zero");
        balances[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
        depositTopThree(msg.sender);
    }

    // 提款
    function withdraw() external override onlyAdmin {
        uint balance = address(this).balance;
        require(balance > 0, "contract balance is zero");
        payable(admin).transfer(balance);
        emit Withdraw(msg.sender, balance);
    }

    // 记录充值前3名
    function depositTopThree(address depositor) internal {
        bool exists = false;
        for(uint256 i = 0; i < topList.length; i++) {
            if(topList[i] == depositor) {
                exists = true;
                break;
            }
        }

        if(!exists) {
            topList.push(depositor);
        }

        for (uint256 i = 0; i < topList.length; i++) {
            for (uint256 j = i + 1; j < topList.length; j++) {
                if (balances[topList[i]] < balances[topList[j]]) {
                    address temp = topList[i];
                    topList[i] = topList[j];
                    topList[j] = temp;
                }
            }
        }

        if(topList.length > 3) {
            topList.pop();
        }
    }

    // 获取地址余额
    function getBalance(address addr) external view override returns(uint256) {
        return balances[addr];
    }

    // 获取前3位的地址和余额
    function getTop() external view override returns(Account[] memory) {
        Account[] memory accounts = new Account[](3);
        for (uint256 i = 0; i < topList.length; i++) {
            accounts[i] = Account({addr: topList[i], balance: balances[topList[i]]});
        }
        return accounts;
    }

    // 即使不调用deposit, 也可以直接给合约转帐
    receive() external payable { 
        this.deposit();
    }
}