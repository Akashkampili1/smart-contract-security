# Reentrancy Attack

## Overview
Reentrancy is one of the most common vulnerabilities in smart contracts. This attack occurs when a contract makes an external call to another contract before updating its own state, allowing the called contract to re-enter and manipulate the state unexpectedly.

## Project Structure
```
Reentrancy Attacks/
├── contracts/
│   ├── ReentrancyVulnerable.sol # Vulnerable contract
│   ├── ReentrancyAttacker.sol # Attack contract
├── scripts/
│   ├── exploit.js           # Exploit script
├── test/
│   ├── Lock.js   
├── README.md
├── hardhat.config.js        # Hardhat configuration
├── package.json
```

## Setup Instructions

### 1. Install Dependencies
Ensure you have [Node.js](https://nodejs.org/) installed, then run:
```sh
npm install --save-dev hardhat ethers 
```

### 2. Start Hardhat Local Node
```sh
npx hardhat node
```

### 3. Deploy the Vulnerable Contract
```sh
npx hardhat run scripts/deploy.js --network localhost
```

### 4. Run the Exploit
```sh
npx hardhat run scripts/exploit.js --network localhost
```

## Explanation
The `Reentrancy.sol` contract has a withdraw function that sends Ether before updating the balance, making it vulnerable. The `ReentrancyAttack.sol` contract exploits this by recursively calling `withdraw` before the state is updated.

## Security Fix
To prevent reentrancy attacks, follow best practices such as:
- Use the **Checks-Effects-Interactions** pattern.
- Implement **ReentrancyGuard** from OpenZeppelin.
- Use pull-based withdrawal mechanisms.

---


