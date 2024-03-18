// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Level0} from "../src/Level0.sol";

import {Script, console} from "forge-std/script.sol";

contract Level0solution is Script {
    Level0 public level0 = Level0(0xdBF231448f5739c7aF3e2FaE7Acb9c043208B333);

    function run() public {
        string memory password = level0.password();
        console.log("Password is:", password);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        level0.authenticate(password);
        vm.stopBroadcast();
    }
}
