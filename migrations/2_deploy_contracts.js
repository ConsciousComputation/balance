var BalanceToken = artifacts.require("BalanceToken");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(BalanceToken);
};
