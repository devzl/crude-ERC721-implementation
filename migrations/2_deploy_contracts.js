const CrudeERC721Token = artifacts.require("./CrudeERC721Token.sol")

module.exports = function(deployer) {
	deployer.deploy(CrudeERC721Token);
};