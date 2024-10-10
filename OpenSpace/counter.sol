// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

contract Counter {
    uint counter;
    function get() external view returns(uint) {
        return counter;
    }

    function add(uint x) external {
        counter += x;
    }
}