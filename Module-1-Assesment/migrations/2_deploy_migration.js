const AirplaneManagement = artifacts.require("AirplaneManagement");
module.exports = function (deployer) {
  deployer.deploy(AirplaneManagement);
};