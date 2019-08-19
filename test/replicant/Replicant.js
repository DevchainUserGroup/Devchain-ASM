'user strict';

const assertRevert = require('./helpers/assertRevert');
const Replicant = artifacts.require('../contracts/Replicant.sol');

contract('Replicant', function (accounts) {
  let replicant;

  beforeEach(async function () {
    replicant = await Replicant.new();
  });

});
