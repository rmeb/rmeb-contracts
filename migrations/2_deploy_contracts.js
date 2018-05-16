const AllowanceRegistry = artifacts.require('AllowanceRegistry');

const REGISTRY_OWNER="0x9C803151d0fD38f8C9FCEe7D5d02498dF6067E5A"; //ajunge key


module.exports = function (deployer) {
  deployer.deploy(AllowanceRegistry)
  .then(() => {
    return AllowanceRegistry.deployed();
  })
  .then((instance) => {
    return instance.transferOwnership(REGISTRY_OWNER);
  })
}
