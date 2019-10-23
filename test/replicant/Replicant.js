'user strict';

const assertRevert = require('../helpers/assertRevert');
const Replicant = artifacts.require('Replicant.sol');

contract('Replicant', function (accounts) {
  let replicant;

  beforeEach(async function () {
    replicant = await Replicant.new();
  });

});
