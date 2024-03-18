// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Level1 {
    /*    Objectif

    1.you claim ownership of the contract
    2.you reduce its balance to 0

    */

    mapping(address => uint256) public contributions; //contribution per address
    address public owner; //address of the owner

    constructor() {
        owner = msg.sender;
        contributions[msg.sender] = 1000 * (1 ether);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "caller is not the owner");
        _;
    }
    // step 1 contribue

    function contribute() public payable {
        require(msg.value < 0.001 ether);
        contributions[msg.sender] += msg.value;
        if (contributions[msg.sender] > contributions[owner]) {
            owner = msg.sender;
        }
    }

    function getContribution() public view returns (uint256) {
        return contributions[msg.sender];
    }
    //step 3 withdraw everything

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
    //step 2 take of the roll of owner

    receive() external payable {
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = msg.sender;
    }


}
