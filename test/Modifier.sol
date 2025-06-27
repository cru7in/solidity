// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Modifier{
    address public owner;

    constructor(){
        owner = msg.sender; //컨트랙트배포 owner 주소
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not Owner!");
        _;
    }

    function changeOwner(address _newOwner) public {
        owner = _newOwner;
    }
}