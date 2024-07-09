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
