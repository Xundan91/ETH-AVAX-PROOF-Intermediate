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
