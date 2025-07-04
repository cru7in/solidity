// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract SendEther{
    function sendViaCall(address payable _to) public payable{
        (bool sent,) =_to.call{value: msg.value}("");
        require(sent, "failed to send Ether");
    }

}
