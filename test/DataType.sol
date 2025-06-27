// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract {

    uint num = 123;
    string str = "hello world";    

    function doSomething() public view{
        uint i = 123;
        uint timestamp = block.timestamp;



    }
    function get() public view returns (uint){
        return num;
    }
    function set(uint _num) public {
        num = _num;
    }
}