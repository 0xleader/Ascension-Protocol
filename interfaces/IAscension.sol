// SPDX-License-Identifier: MIT

pragma solidity 0.6.8;

interface IAscension {
  function checkExcluded(address account) external view returns (bool);

  function totalFees() external view returns (uint256);

  function getNumCheckpoints(address account) external view returns (uint256);

  function getPriorValue(address account, uint256 blockNumber) external view returns (uint256);

  function getLevel(address account) external view returns (uint256);

  function distributeShares(uint256 tAmount) external;

  function bulkTransfer(address[] calldata _to, uint256[] calldata _values) external returns (bool);

  function ascensionEvent(
    address payable strategy,
    address[] calldata targets,
    uint256[] calldata values
  ) external;

  function lockLiquidity() external;
}
