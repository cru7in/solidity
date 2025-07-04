// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract HotelRoom{
    // 호텔룸 owner(host)
    address payable public owner;
    
    // 호텔룸 방 예약, 예약되지 않음을 알려주는 변수 
    enum Statuses {Vacant, Occupied}
    Statuses currentStatus;
    
    event Occupy(address _occupant, uint _value);
    constructor(){
        owner = payable(msg.sender);
        currentStatus = Statuses.Vacant; 
    }

    modifier onlyWhileVacant{
        require(currentStatus == Statuses.Vacant, "Currently occupied");
        _;
    }
 
    modifier costs(uint _amout)
    {
        require(msg.value >=_amout, "Not enough");
        _;
    }

    //현재 컨트랙트에 이더가 전송되면 실행됨
    receive() external payable onlyWhileVacant costs(2 ether){
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }

    function getStatuses () public view returns (Statuses)
    {
        return currentStatus;
    }

    // 컨트랙트의 소유자(owner)만이 특정 함수를 실행할 수 있도록 제한
    modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }

    // 소유권이 이전될 때 이전 소유자와 새 소유자의 주소를 기록
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // 1번 문제 관련 : HotelRoom Contract Owner가 HotelRoom Contract 소유권을 다른 계정으로 양도할 수 있는 기능
    function transferOwnership(address payable newOwner) public onlyOwner {
        // 이벤트를 발생시켜 소유권 변경 기록을 남김
        emit OwnershipTransferred(owner, newOwner);
        // owner 변수의 값을 새로운 소유자의 주소 newOwner 로 변경
        owner = newOwner;
    }

    // 2번 문제 관련 : HotelRoom의 Statuses를 Occupied에서 Vacant로 변경하는 기능
    function makeVacant() public onlyOwner {
        // 현재 방 상태가 확인하고 Occupied가 아니면 메세지를 출력하고 함수는 끝남
        require(currentStatus == Statuses.Occupied, "Room is already vacant.");
        // 방 상태는 vancat로 변경
        currentStatus = Statuses.Vacant;
    }
}
