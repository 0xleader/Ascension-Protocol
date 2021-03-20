// SPDX-License-Identifier: MIT

pragma solidity 0.6.8;

interface IAscensionStrategy {
  function validateProposal(address[] calldata targets, uint256[] calldata values)
    external
    returns (bool);

  function executeStrategy(address[] calldata targets, uint256[] calldata values)
    external
    returns (bool);
}
