pragma solidity ^0.5.0;


/**
 * @title ConvertBytes8
 *
 * @notice Copyright © 2016 - 2019 Mt Pelerin Group SA - All Rights Reserved
 * @notice This content cannot be used, copied or reproduced in part or in whole
 * @notice without the express and written permission of Mt Pelerin Group SA.
 * @notice Written by *Mt Pelerin Group SA*, <info@mtpelerin.com>
 * @notice All matters regarding the intellectual property of this code or software
 * @notice are subjects to Swiss Law without reference to its conflicts of law rules.
 *
 * Error messages
 * SC01: No ETH must be provided for the challenge
 * SC02: Target must not be null
 * SC03: Execution call must be successful
 * SC04: Challenge must be active
 * SC05: Challenge must be no more than challenge bytes
 *
 * @author Cyril Lapinte - <cyril.lapinte@mtpelerin.com>
 */
contract ConvertBytes8 {

  function convertBytesToBytes8(bytes memory inBytes) public pure returns (bytes8 outBytes8) {
    uint256 maxByteAvailable = inBytes.length < 8 ? inBytes.length : 8;
    for (uint256 i = 0; i < maxByteAvailable; i++) {
        bytes8 tempBytes8 = inBytes[i];
        tempBytes8 = tempBytes8 >> (8 * i);
        outBytes8 = outBytes8 | tempBytes8;
    }
  }

  function convertBytesToBytes8Asm(bytes memory inBytes) public pure returns (bytes8 outBytes8) {
    if (inBytes.length == 0) {
        return 0x0;
    }

    assembly {
        outBytes8 := mload(add(inBytes, 32))
    }
  }

  function convertBytesToBytes8Explained(bytes memory inBytes) public pure returns
    (uint256 length, bytes32 outBytesPtr, bytes32 outBytes32, bytes8 outBytes8)
  {
    if (inBytes.length == 0) {
        return (0, 0x0, 0x0, 0x0);
    }

    assembly {
      // The bytes is represented in ASM by it's address
      outBytesPtr := inBytes
      // First bytes32 in a dynamic structure is the length
      length := mload(inBytes)

      // Next bytes32 is the first value
      outBytes32 := add(inBytes, 32)

      // Loading its content into a bytes8 will convert it
      outBytes8 := mload(add(inBytes, 32))
    }
  }
}
