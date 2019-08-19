pragma solidity ^0.5.0;


/**
 * @title ConvertBytes8
 *
 * Error messages
 *
 * @author Cyril Lapinte - <cyril.lapinte@gmail.com>
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
