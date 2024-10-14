// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
// 代币:合约地址:owner
// MM:0x609025291C9B176C15cEe617C6e75EC5374384Fb:0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
// FF:0x298DE19cD26155227a918B12c995897974F79d0D:0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2
// TokenBank:0x2d5eb40e24615cA3415d3cC6961Bc2e9Ca2582D7:0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
// 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB

// User
// 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB has MM 1000, has FF 2000

contract TokenBank {
    constructor() {
        tokenBankAddr = address(this);
        owner = msg.sender;
    }

    mapping(address => uint256) balances;
    address public tokenBankAddr;
    address public owner;

    // 一个银行可以存多种token, 类似于银行有多种货币
    mapping(IERC20 => mapping(address => uint256)) erc20token;

    event Deposit(address, uint256);
    event Widthdraw(address, uint256);
    event AdminWithdraw(address, uint256);

    function deposit(IERC20 token,uint256 amount) public {
        require(amount > 0, "amount must be more than 0");
        token.transferFrom(msg.sender, address(this), amount);
        erc20token[token][msg.sender] += amount;

        emit Deposit(msg.sender, amount);
    }

    function widthdraw(IERC20 token) public payable {

        uint256 balance = erc20token[token][msg.sender];
        require(balance > 0,"no balance can withdraw");
        token.transfer(msg.sender, balance);
        erc20token[token][msg.sender] = 0;

        emit Widthdraw(msg.sender, balance);
    }

    function getBalance(IERC20 token) public view returns (uint256) {
        return erc20token[token][msg.sender];
    }

    function adminWithdraw(IERC20 token) public {
        uint256 totalBalance = erc20token[token][msg.sender];
        require(totalBalance > 0, "bank no money");
        token.transfer(owner, totalBalance);

        emit AdminWithdraw(msg.sender, totalBalance);
    }
}