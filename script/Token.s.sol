// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import {Token} from "../src/Token.sol";
import {Script, console} from "forge-std/script.sol";

contract TokenSolution is Script {
    Token token = Token(0xD0c9C88186D83172971748B1B68A8C7B46fDC89E);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Amount before transaction is:", token.balanceOf(msg.sender));
        token.transfer(0xD0c9C88186D83172971748B1B68A8C7B46fDC89E, 200);
        console.log("Amount after transaction is:", token.balanceOf(0x73de6b8e575D8B31A89568e9B3d0b3E89C25d8e5));
        vm.stopBroadcast();
    }
}
