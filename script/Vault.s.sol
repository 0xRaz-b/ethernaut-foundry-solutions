// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Vault} from "../src/Vault.sol";
import {Script, console} from "forge-std/script.sol";

contract VaultSolution is Script {
    Vault vault = Vault(0xA25Bed661198310A7Fdba360132A7b681cE996d1);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("The lock before is :", vault.locked());
        vault.unlock(0x412076657279207374726f6e67207365637265742070617373776f7264203a29);
        console.log("The lock after is :", vault.locked());
        vm.stopBroadcast();
    }
}
