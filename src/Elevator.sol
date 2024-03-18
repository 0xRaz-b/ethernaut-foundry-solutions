// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint256) external returns (bool);
}

contract Elevator {
    bool public top;
    uint256 public floor;

    function goTo(uint256 _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {  // if it's not last floor ==> it needs to be false 
            floor = _floor;                   // we stor _floor in floor
            top = building.isLastFloor(floor); // it needs to be true
        }
    }
}
