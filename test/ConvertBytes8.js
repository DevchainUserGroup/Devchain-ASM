'user strict';

const assertRevert = require('./helpers/assertRevert');
const ConvertBytes8 = artifacts.require('../contracts/ConvertBytes8.sol');

contract('ConvertBytes8', function (accounts) {
  const data = web3.utils.toHex("ABCDEFGHIJKLMN");
  let convertBytes8;

  beforeEach(async function () {
    convertBytes8 = await ConvertBytes8.new();
  });

  it('should convertBytesToBytes8', async function () {
    const bytes8 = await convertBytes8.convertBytesToBytes8(data);
    assert.equal(bytes8, '0x4142434445464748', 'bytes8');
  });

  it('should convertBytesToBytes8Asm', async function () {
    const bytes8 = await convertBytes8.convertBytesToBytes8Asm(data);
    assert.equal(bytes8, '0x4142434445464748', 'bytes8');
  });

  it('should convertBytesToBytes8Explained', async function () {
    const explaination = await convertBytes8.convertBytesToBytes8Explained(data);
    assert.equal(explaination[0].toString(), 14, 'bytes length');
    assert.equal(explaination[1], '0x0000000000000000000000000000000000000000000000000000000000000080', 'bytes ptr');
    assert.equal(explaination[2], '0x00000000000000000000000000000000000000000000000000000000000000a0', '1st value ptr');
    assert.equal(explaination[3], '0x4142434445464748', 'bytes8');
  });

});
