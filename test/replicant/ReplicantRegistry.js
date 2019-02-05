'user strict';

/**
 * @author Cyril Lapinte - <cyril.lapinte@mtpelerin.com>
 *
 * Copyright © 2016 - 2019 Mt Pelerin Group SA - All Rights Reserved
 * This content cannot be used, copied or reproduced in part or in whole
 * without the express and written permission of Mt Pelerin Group SA.
 * Written by *Mt Pelerin Group SA*, <info@mtpelerin.com>
 * All matters regarding the intellectual property of this code or software
 * are subjects to Swiss Law without reference to its conflicts of law rules.
 *
 */

const assertRevert = require('./helpers/assertRevert');
const ReplicantRegistry = artifacts.require('../contracts/ReplicantRegistry.sol');

contract('ReplicantRegistry', function (accounts) {
  let registry;

  beforeEach(async function () {
    registry = await ReplicantRegistry.new();
  });

});
