Below is an example `README.md` file that documents the vulnerabilities, the contract code, and instructions on how to run the exploit script:

```markdown
# VulnerableToken: Integer Overflow & Underflow Demonstration

This project demonstrates how integer overflow and underflow vulnerabilities can occur in Solidity smart contracts when using unchecked arithmetic operations.

## Overview

The `VulnerableToken` contract implements two separate vulnerabilities:

- **Integer Overflow:**  
  A `uint8` counter variable is incremented using an `unchecked` block. When the sum exceeds the maximum value of `255`, it wraps around to a lower value. For example, incrementing `250` by `10` results in `260`, which overflows and becomes `4`.

- **Integer Underflow:**  
  The token balance for each account is stored as a `uint8` in the `balances` mapping. The `spend` function subtracts tokens using an `unchecked` block. If you try to spend tokens when your balance is `0`, the subtraction underflows and wraps around to `255`.

## Contract Code

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract VulnerableToken {
    // Mapping to track token balances (vulnerable to underflow in the spend function)
    mapping(address => uint8) public balances;

    // Counter variable to demonstrate an integer overflow vulnerability
    uint8 public counter;

    // Mint tokens to the caller (increases the balance)
    function mint(uint8 amount) public {
        unchecked {
            balances[msg.sender] += amount;
        }
    }

    // Spend tokens (vulnerable to underflow)
    function spend(uint8 amount) public {
        unchecked {
            balances[msg.sender] -= amount;
        }
    }

    // Increment the counter (vulnerable to overflow)
    function increment(uint8 amount) public {
        unchecked {
            counter += amount;
        }
    }
}
```

## How the Vulnerabilities Work

### Integer Overflow Exploit

- **Scenario:**  
  The counter is a `uint8` (range: 0 to 255).  
- **Steps:**  
  1. Initially, the counter is `0`.
  2. Calling `increment(250)` sets the counter to `250`.
  3. Calling `increment(10)` increases the counter to `260`, which exceeds `255`. Due to overflow, it wraps around and becomes `4` (i.e., `260 % 256 = 4`).

### Integer Underflow Exploit

- **Scenario:**  
  The token balance is stored as a `uint8` in the `balances` mapping.  
- **Steps:**  
  1. An account's balance is initially `0`.
  2. Calling `spend(1)` subtracts `1` from `0`. Since underflow is unchecked, the balance wraps around to `255`.

## Running the Exploit

### Prerequisites

- [Node.js](https://nodejs.org/)
- [Hardhat](https://hardhat.org/)  
  Install Hardhat and dependencies using:

  ```bash
  npm install --save-dev hardhat
  ```

### Steps

1. **Compile the Contract**

   ```bash
   npx hardhat compile
   ```

2. **Deploy and Run the Exploit Script**

   The provided script (e.g., `scripts/exploitCounter.js`) deploys the contract and demonstrates both the overflow and underflow vulnerabilities.

   ```bash
   npx hardhat run scripts/exploitCounter.js --network localhost
   ```

3. **Review the Output**

   You should see output similar to:

   ```
   === Deploying VulnerableToken ===
   VulnerableToken deployed at: 0x...
   
   === Integer Overflow Exploit on Counter ===
   Initial counter value: 0
   Counter value after incrementing by 250: 250
   Counter value after incrementing by 10 (overflow expected): 4
   
   === Integer Underflow Exploit on Balances ===
   Initial token balance: 0
   Token balance after underflow exploit (expected 255): 255
   ```

## Important Note

**Disclaimer:**  
This project is for educational purposes only. Exploiting vulnerabilities in production smart contracts without proper authorization is illegal and unethical. Always use such knowledge responsibly.

## Conclusion

This demonstration highlights the risks of using unchecked arithmetic in smart contracts. Solidity versions 0.8.x and above include automatic overflow and underflow checks, but using `unchecked` blocks bypasses these protections, exposing your contracts to critical vulnerabilities.

Happy learning!
```

Feel free to modify this `README.md` file to better suit your project's needs or add additional information.