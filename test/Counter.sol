// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Counter { 
    uint count;

    function incrementCount() public {
        count = count + 1;
    }
    
    function getCount() public view returns (uint) {
        return count;
    }
}