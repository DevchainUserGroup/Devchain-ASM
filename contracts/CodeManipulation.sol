pragma solidity ^0.5.0;


/**
 * @title CodeManipulation
 *
 * @notice Copyright © 2016 - 2019 Mt Pelerin Group SA - All Rights Reserved
 * @notice This content cannot be used, copied or reproduced in part or in whole
 * @notice without the express and written permission of Mt Pelerin Group SA.
 * @notice Written by *Mt Pelerin Group SA*, <info@mtpelerin.com>
 * @notice All matters regarding the intellectual property of this code or software
 * @notice are subjects to Swiss Law without reference to its conflicts of law rules.
 *
 * Error messages
 *
 * @author Cyril Lapinte - <cyril.lapinte@mtpelerin.com>
 */
contract CodeManipulation {

  bytes public bytecode;

  constructor() public {
    bytecode = self();
  }

  function self() public pure returns (bytes memory code) {
    assembly {
      let size := codesize
      code := mload(0x40)

      mstore(0x40, add(code, and(add(add(size, 0x20), 0x1f), not(0x1f))))
      mstore(code, size)
      codecopy(add(code, 0x20), 0, size)
    }
  }

  function deploy() public returns (address _address) {
    bytes memory code = bytecode;
    assembly {
      _address := create(0, add(code, 0x20), mload(code))
    }
    emit ContractDeployed(_address);
  }

  event ContractDeployed(address _address);
}
