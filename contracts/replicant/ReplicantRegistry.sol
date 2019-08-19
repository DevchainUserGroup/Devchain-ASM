pragma solidity ^0.5.0;


/**
 * @title ReplicantRegistry
 *
 * Error messages
 *
 * @author Cyril Lapinte - <cyril.lapinte@gmail.com>
 */
contract ReplicantRegistry {

  mapping(uint256 => address) public replicants;
  uint256 public counts;

  constructor() public {
  }

  function register() public {
    replicants[++counts] = msg.sender;
  }

  event Replicated(address _address);
}
