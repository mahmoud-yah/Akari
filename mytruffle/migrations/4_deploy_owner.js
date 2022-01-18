const Owner = artifacts.require("./Owner.sol");

module.exports = function(deployer) {
  deployer.deploy(Owner,"Mahmoud","Yahya","Hun","Ahmad",1041002);
};
