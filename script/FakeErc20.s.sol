// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {FakeIERC20} from "../src/FakeErc20.sol";
import {Script, console} from "forge-std/Script.sol";
import {DexTwo} from "../src/DexTwo.sol";
import {Script, console} from "forge-std/Script.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract deployFakeErc20 is Script {
    DexTwo dexTwo = DexTwo(0xe14712e768A0e7bcBE04CeB22555ff509284F9Ad);

    address myAddress = vm.envAddress("MY_ADDRESS");
    address dexAddress = address(dexTwo);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        FakeIERC20 fakeToken = new FakeIERC20();
        fakeToken.mintToken(myAddress, 5000);
        fakeToken.mintToken(dexAddress, 500);

        vm.stopBroadcast();
    }
}
