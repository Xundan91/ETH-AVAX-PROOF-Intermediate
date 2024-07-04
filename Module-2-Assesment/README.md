# Decentralized Exchange

After cloning the github, you will want to do the following to get the code running on your computer.

## Description

This contract depicts an decentralized exchange where you can deposit/withdraw your tokens and also penalize and set interest them for earning rewards. Here you can interact with with the front end and get access to backend of the solidity .

## Executing program

### Installing

Make sure you have install Nodejs.
1. Inside the project directory, in the terminal type: `npm install`
2. Open two additional terminals in your VS code

### Executing program
3. In the second terminal type: `npx hardhat node`(copy the address ) and make localHost on metamask using this address(As balance will deposit on this address
4. In the third terminal, type: `npx hardhat run --network localhost scripts/deploy.js`
   
5. Back in the first terminal, type `npm run dev` to launch the front-end.

After this, the project will be running on your localhost. 
Typically at http://localhost:3000/


On clicking on Button Like Penelize and Interest The address get reduction in balance and Increase in balance respectively.

## Authors(or Contributors)

kundan kumar

## License

This project is licensed under the [MIT] License - see the LICENSE.md file for details
