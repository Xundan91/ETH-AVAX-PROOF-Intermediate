# Creating and deploying on the Avax C-chain

Creating and deplying DegenToken on the Avax C-chain for Degen Gaming.

## The contract was verified on the Avalanche fuji (testnet) C-Chain


[link to verification](https://testnet.snowtrace.io/address/0x2726f91c50c94cE0a4DE2b66e4B624f8BdabCe64#code)

## Getting Started

### Installing

  1. Clone the [repository](https://github.com/Xundan91/ETH-AVAX-PROOF-Intermediate) using `git clone https://github.com/Xundan91/ETH-AVAX-PROOF-Intermediate.git`
  2. Move to the project directory using `cd Module-4-Assessment`
  3. Copy your Wallet's private key that contains [AVAX faucet tokens](https://core.app/tools/testnet-faucet/) or (In MetaMask copy in account details)
  4. Enter the key in `hardhat.config.js`

### Executing program

  1. Intall required dependencies using `npm i`
  2. Deploy on fuji chain (testnet for c-chain) using `npx hardhat run scripts/deploy.js --network fuji`
  3. Verify on snowtrace using `npx hardhat verify --network fuji YOUR_CONTRACT_ADDRESS`

Congratulations! you have successfully deployed the contract. Now use the contract address returned after deploying to check it on the [avalanche testnet block chain](https://testnet.snowtrace.io/).

Further functions provided can be tested on [Remix IDE](https://remix.ethereum.org/)


## Help

Any advise for common problems or issues.
```
command to run if program contains helper info
```

## Authors

Contributors names and contact info

- kundan Kumar
- kundansingh023230@gmail.com

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
