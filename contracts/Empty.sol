pragma solidity ^0.5.0;


/**
 * @title Empty
 *
 * Error messages
 *
 * @author Cyril Lapinte - <cyril.lapinte@gmail.com>
 */
contract Empty {

  function getThis() public view returns (address) {
    return address(this);
  }

}
