'user strict';

const assertRevert = require('./helpers/assertRevert');
const ReplicantRegistry = artifacts.require('../contracts/ReplicantRegistry.sol');

contract('ReplicantRegistry', function (accounts) {
  let registry;

  beforeEach(async function () {
    registry = await ReplicantRegistry.new();
  });

});
