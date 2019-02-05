pragma solidity ^0.5.0;

import "./ReplicantRegistry.sol";


/**
 * @title Replicant
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
contract Replicant {

  string public name;
  bytes public bytecode;

  Replicant public parent;
  ReplicantRegistry public registry;

  constructor() public {
    bytecode = self();
    if(isReplicant(msg.sender)) {
      parent = Replicant(msg.sender);
      registry = parent.registry();
      registry.register();
    }
  }

  function setName(string memory _name) public {
    name = _name;
  }

  function setBytecode(bytes memory _bytecode) public {
    bytecode = _bytecode;
  }

  function setRegistry(ReplicantRegistry _registry) public {
    registry = _registry;
    registry.register();
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

  function other(address _other) public view returns (bytes memory code) {
    assembly {
      let size := extcodesize(_other)
      code := mload(0x40)

      mstore(0x40, add(code, and(add(add(size, 0x20), 0x1f), not(0x1f))))
      mstore(code, size)
      extcodecopy(_other, add(code, 0x20), 0, size)
    }
  }

  function isReplicant(address _other) public view returns (bool) {
    return keccak256(self()) == keccak256(other(_other));
  }

  function replicate() public returns (address _address) {
    bytes memory code = bytecode;
    assembly {
      _address := create(0, add(code, 0x20), mload(code))
    }
    emit Replicated(_address);
  }

  function terminate() public {
    require(isReplicant(msg.sender), "RP01");
    selfdestruct(address(uint160(address(parent))));
  }

  event Replicated(address _address);
}
