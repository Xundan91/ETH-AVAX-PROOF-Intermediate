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
