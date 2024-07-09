
# Creating and deploying on the Avax C-chain

Creating and deplying DegenToken on the Avax C-chain for Degen Gaming.

## The contract was verified on the Avalanche fuji (testnet) C-Chain

![meta3](https://github.com/Xundan91/ETH-AVAX-PROOF-Intermediate/assets/38605640/c7ef5c5e-76ab-41d8-882d-6e35598ab282)

![Meta2](https://github.com/Xundan91/ETH-AVAX-PROOF-Intermediate/assets/38605640/ea3fdc54-402a-4cee-872e-0c8058abf475)

[Link to Verification](https://testnet.snowtrace.io/address/0x2726f91c50c94cE0a4DE2b66e4B624f8BdabCe64#code)

## Getting Started

### Installing

  1. Clone the [repository](https://github.com/Xundan91/ETH-AVAX-PROOF-Intermediate) using `git clone https://github.com/Xundan91/ETH-AVAX-PROOF-Intermediate.git`
  2. Move to the project directory using `cd Module-4-Assessment`
  3. Copy your Wallet's private key that contains [AVAX faucet tokens](https://core.app/tools/testnet-faucet/) or (In MetaMask copy Private key in account details)
  4. Enter the key in `hardhat.config.js`

### Executing program
```solidity 

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    struct InventoryEntry {
        string itemName;
        uint256 quantity;
    }

    mapping(address => mapping(uint256 => InventoryEntry)) public userInventory;
    mapping(address => uint256[]) public userInventoryItemIds;

    struct StoreItem {
        string itemName;
        uint256 cost;
    }
    StoreItem[] public store;

    constructor() ERC20("DegenToken", "DGT") {
        _mint(msg.sender, 100 * 10 ** decimals()); // Mint 100 tokens initially
        // Initialize store with 4 items
        store.push(StoreItem("Sword", 10));
        store.push(StoreItem("Shield", 20));
        store.push(StoreItem("Arrows", 30));
        store.push(StoreItem("Helmet", 40));
    }

    function mintTokens(address recipient, uint256 amount) external onlyOwner {
        _mint(recipient, amount * 10 ** decimals());
    }

    function transferTokens(address recipient, uint256 amount) public returns (bool) {
        _transfer(_msgSender(), recipient, amount * 10 ** decimals());
        return true;
    }

    function burnTokens(uint256 amount) external {
        require(balanceOf(msg.sender) >= amount * 10 ** decimals(), "Insufficient balance");
        _burn(msg.sender, amount * 10 ** decimals());
    }

    function getBalance(address account) external view returns (uint256) {
        return balanceOf(account) / 10 ** decimals();
    }

    function redeemItem(uint256 itemId) external {
        require(itemId - 1 < store.length, "Invalid item ID");
        StoreItem storage item = store[itemId - 1];
        require(balanceOf(msg.sender) >= item.cost * 10 ** decimals(), "Insufficient tokens");

        _burn(msg.sender, item.cost * 10 ** decimals());

        InventoryEntry storage inventoryEntry = userInventory[msg.sender][itemId - 1];
        if (bytes(inventoryEntry.itemName).length == 0) {
            inventoryEntry.itemName = item.itemName;
            userInventoryItemIds[msg.sender].push(itemId - 1);
        }
        inventoryEntry.quantity += 1;
    }

    function getStoreItems() external view returns (StoreItem[] memory) {
        return store;
    }

    function getUserInventory(address player) external view returns (InventoryEntry[] memory) {
        uint256[] storage itemIds = userInventoryItemIds[player];
        uint256 length = itemIds.length;
        InventoryEntry[] memory inventory = new InventoryEntry[](length);
        
        for (uint256 i = 0; i < length; i++) {
            uint256 itemId = itemIds[i];
            inventory[i] = userInventory[player][itemId];
        }
        
        return inventory;
    }
}




```

  1. Intall required dependencies using `npm i`
  2. Deploy on fuji chain (testnet for c-chain) using `npx hardhat run scripts/deploy.js --network fuji`
  3. Verify on snowtrace using `npx hardhat verify --network fuji YOUR_CONTRACT_ADDRESS`

Congratulations! you have successfully deployed the contract. Now use the contract address returned after deploying to check it on the [avalanche testnet block chain](https://testnet.snowtrace.io/).

## Further functions provided can be tested on [Remix IDE](https://remix.ethereum.org/)

- Copy the Deployed address to remix-IDE
- paste the the Address and Deploy it.
- Now you can Interact with mintTokens, burnTokens,transferTokens, redeemItem



## Help

Any advise for common problems or issues.
```readme
contact
-Kundansingh023230@gmail.com
```

## Authors

Contributors names and contact info

- kundan Kumar
- kundansingh023230@gmail.com

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
