// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract ReentrancyVulnerable {
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdraw() external {
        uint256 amount = balances[msg.sender];
        require(amount > 0, "Nothing to withdraw");

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");

        balances[msg.sender] = 0; // This should be before sending Ether
    }

    function getBalance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
