// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract VulnerableToken {
    // Mapping to track token balances (vulnerable to underflow in the spend function)
    mapping(address => uint8) public balances;

    // Counter variable to demonstrate an integer overflow vulnerability
    uint8 public counter;

    // Mint tokens to the caller (you can mint tokens to increase your balance)
    function mint(uint8 amount) public {
        // Using unchecked to allow potential overflow (if desired)
        unchecked {
            balances[msg.sender] += amount;
        }
    }

    // Spend tokens (vulnerable to underflow)
    function spend(uint8 amount) public {
        // Using unchecked to disable Solidity's built-in underflow check.
        unchecked {
            balances[msg.sender] -= amount;
        }
    }

    // Increment the counter (vulnerable to overflow)
    function increment(uint8 amount) public {
        // Using unchecked to disable Solidity's built-in overflow check.
        unchecked {
            counter += amount;
        }
    }
}
