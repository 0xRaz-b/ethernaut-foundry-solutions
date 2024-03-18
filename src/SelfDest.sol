// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SelfDest {
    constructor(address payable _add) payable {
        selfdestruct(_add);
    }
}
