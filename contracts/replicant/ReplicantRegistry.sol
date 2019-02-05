pragma solidity ^0.5.0;


/**
 * @title ReplicantRegistry
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
