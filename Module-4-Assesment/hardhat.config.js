require("@nomicfoundation/hardhat-toolbox");
const { ethers } = require("hardhat");

const FORK_FUJI = process.env.FORK_FUJI === 'true';
const FORK_MAINNET = process.env.FORK_MAINNET === 'true';
const AVALANCHE_RPC_URL = process.env.AVALANCHE_RPC_URL || 'https://api.avax.network/ext/bc/C/rpcc';
const AVALANCHE_TEST_RPC_URL = process.env.AVALANCHE_TEST_RPC_URL || 'https://api.avax-test.network/ext/bc/C/rpc';


let forkingData = undefined;

if (FORK_MAINNET) {
  forkingData = {
    url: AVALANCHE_RPC_URL,
  }
}
if (FORK_FUJI) {
  forkingData = {
    url: AVALANCHE_TEST_RPC_URL,
  }
}

module.exports = {
  solidity: "0.8.20",
  etherscan: {
    apiKey: {
      avalancheFujiTestnet: ETHERSCAN_API_KEY
    },
  },
  networks: {
    hardhat: {
      gasPrice: 25000000000,
      chainId: !forkingData ? 43112 : undefined, // Only specify a chainId if we are not forking
      forking: forkingData
    },
  
    fuji: {
      url: AVALANCHE_TEST_RPC_URL,
      gasPrice: 25000000000,
      chainId: 43113,
      accounts: [FUJI_ACCOUNT_PRIVATE_KEY]
    },
    
    // mainnet: {
    //   url: AVALANCHE_RPC_URL,
    //   gasPrice: 225000000000,
    //   chainId: 43114,
    //   accounts: [
    //     "ac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80"
    //   ]
    // }
  }
}
