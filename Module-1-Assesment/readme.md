# Error examples! in Solidity

## Install

1. Install [Node.js](https://nodejs.org)

   Download and install from the official site.

2. Install [Truffle](https://github.com/trufflesuite/truffle)

   ```bash
   npm install -g truffle
   ```

## Initialize

1. Initialize Truffle in your project folder

   ```bash
   truffle init
   ```

   After initialization, you will find two folders called `contracts` and `migrations`. Contracts go in the `contracts` folder while contract deployment settings go in `migrations`.

2. The "AirplaneManagement" contract

   This is an example of a "AirplaneManagement" contract in Solidity.
   "airplaneManagement.sol" in `contracts` contains the following code:

   ```solidity
   // SPDX-License-Identifier: MIT
   pragma solidity ^0.8.17;
   contract AirplaneManagement {
    struct Flight {
    string flightName;
    bool hasDeparted;
    }

    mapping(uint => Flight) public flights;

    function scheduleFlight(uint _flightId, string memory _flightName) public {
        require(bytes(_flightName).length > 0, "Flight name cannot be empty");
        require(bytes(flights[_flightId].flightName).length == 0, "Flight already scheduled");

        flights[_flightId] = Flight({
            flightName: _flightName,
            hasDeparted: false
        });
    }

    function departFlight(uint _flightId) public {
        require(!flights[_flightId].hasDeparted, "Flight has already departed");
        assert(bytes(flights[_flightId].flightName).length > 0);

        flights[_flightId].hasDeparted = true;
    }

    function cancelFlight(uint _flightId) public {
        if (bytes(flights[_flightId].flightName).length == 0) {
            revert("Flight does not exist");
        }
        require(!flights[_flightId].hasDeparted, "Cannot cancel a departed flight");

        delete flights[_flightId];
    }
}

````

3. Prepare the migration

"2_deploy_migration.js" in `migrations` contains the following code:

```javascript
    const AirplaneManagement = artifacts.require("AirplaneManagement");
    module.exports = function (deployer) {
    deployer.deploy(AirplaneManagement);
    };
````

4. Start Truffle console in development mode

   ```bash
   truffle develop
   ```

   In the Truffle console, execute

   ```bash
   compile
   migrate
   ```

   If you want to remigrate existing contracts, run `migrate --reset` instead of simply `migrate`.

5. Test your contract

   _Get the Deployed Contract Instance_

   ```javascript
   const airplaneManagement = await AirplaneManagement.deployed();
   ```

   This command retrieves the deployed instance of `AirplaneManagement`.

   _add a ScheduleFlight to the_

   ```javascript
   await airplaneManagement.scheduleFlight(1, "Flight1");
   ```

   This command adds a ScheduleFlight with ID 1 and title "Flight1" to the library.

   _departFLight_

   ```javascript
   await airplaneManagement.departFlight(1);
   ```

   This command to departFlight flight of id 1.

   _cancel flight_

   ````javascript
    await airplaneManagement.cancelFlight(1);   ```

   This command cancel flight.
   ````
