# Creating and deplying token using ERC20

## Simple overview of use/purpose.

This contract is an ERC20-compliant token built on the Ethereum blockchain. This token allows the owner to mint new tokens to any specified address. Additionally, any user can burn and transfer tokens, enabling a flexible and decentralized token economy.

## Description

MyToken is a customizable ERC20 token implemented using OpenZeppelin's ERC20 and Ownable contracts. The smart contract allows the owner to mint new tokens to any address, while any token holder can burn their tokens, providing a simple and secure way to manage token supply. The contract is designed to be deployed using tools like HardHat or Remix.

## Getting Started

### Installing 

#### How/where to download your program 

You can download the project source code from the GitHub repository: [module-3 GitHub Repository](https://github.com/Xundan91/ETH-AVAX-PROOF-Intermediate/tree/main/Module-3-Assesment/WithLibary.sol).




#### Any modifications needed to be made to files/folders

No specific modifications are needed. Ensure you have the correct versions of the dependencies specified in the `import` statements.

### Executing program

#### How to run the program

1. **Open Remix:**

    Go to [Remix IDE](https://remix.ethereum.org/).

2. **Create a new file:**

    In the file explorer, click on the "contracts" folder, then click the "+" icon to create a new file. Name it `MyToken.sol`.

3. **Copy and paste the contract code:**

    Copy the following code into the `WithLibrary.sol` file:

    ```solidity
    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.0;
    
    import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";
    import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/access/Ownable.sol";
    
    contract MyToken is ERC20, Ownable {
        constructor() ERC20("MyToken", "Spyx") {}

        function mint(address to, uint256 amount) external onlyOwner {
            _mint(to, amount);
        }
    
        function transferTokens(address to, uint256 amount) external {
            require(to != address(0), "Incorrect address");
            require(balanceOf(msg.sender) >= amount, "Amount to be tranfered exceeds");
            
            _transfer(msg.sender, to, amount);
        }
    
        function burn(uint256 amount) external {
            _burn(msg.sender, amount);
        }

    }
    ```

4. **Compile the contract:**

    Click on the "Solidity Compiler" tab on the left sidebar, select the appropriate compiler version (0.8.0 or above), and click "Compile MyToken.sol".

5. **Deploy the contract:**

    - Click on the "Deploy & Run Transactions" tab on the left sidebar.
    - Ensure "Environment" is set to "Injected Web3" to use MetaMask, or "Remix VM (London)" for a local deployment.
    - Select the `MyToken` contract from the "Contract" dropdown.
    - Provide the constructor arguments: the name and symbol of your token (e.g., "MyToken", "Spyx").
    - Click "Deploy".

6. **Interact with the contract:**

    After deployment, the contract instance will appear in the "Deployed Contracts" section.

    - **Mint tokens:**
        1. Expand the deployed contract.
        2. Find the `mint` function.
        3. Enter the recipient address and the amount of tokens to mint.
        4. Click "transact".
           
    - **Transfer tokens:**
        1. Expand the deployed contract.
        2. Find the `transferTokens` function.
        3. Enter the recipient address and the amount of tokens to transfer.
        4. Click "transact".

    - **Burn tokens:**
        1. Find the `burn` function.
        2. Enter the amount of tokens to burn.
        3. Click "transact".

### Help

Any advice for common problems or issues.

- Ensure your development environment is correctly set up with Node.js and HardHat.
- Verify the contract address after deployment and use the correct address for interactions.
- Check the Ethereum network configuration in HardHat or Remix settings.


## Authors

- Kundan Kumar
- kundansingh023230@gmail.com


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
