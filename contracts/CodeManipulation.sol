pragma solidity ^0.5.0;


/**
 * @title CodeManipulation
 *
 * Error messages
 *
 * @author Cyril Lapinte - <cyril.lapinte@gmail.com>
 */
contract CodeManipulation {

  bytes public bytecode;

  constructor() public {
    bytecode = self();
  }

  function self() public pure returns (bytes memory code) {
    assembly {
      let size := codesize
      code := mload(0x40) // Allocate free memory

      // allocate size memory for code variable
      mstore(0x40, add(code, and(add(add(size, 0x20), 0x1f), not(0x1f))))

      // first byte32 put the size of code
      mstore(code, size)

      // copy contract code into code variable in memory
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
