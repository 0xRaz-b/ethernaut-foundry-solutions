// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {DexTwo} from "../src/DexTwo.sol";
import {Script, console} from "forge-std/Script.sol";
import {IERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol";
import {ERC20} from "../lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract FakeIERC20 is ERC20, Script {
    constructor() ERC20("BOOM", "BOOM") {}

    function mintToken(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }
}
