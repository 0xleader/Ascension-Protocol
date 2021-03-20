// File: contracts/interfaces/IAscensionStrategy.sol

pragma solidity 0.6.8;

interface IAscensionStrategy {
    function validateProposal(
        address[] calldata targets,
        uint256[] calldata values
    ) external returns (bool);

    function executeStrategy(
        address[] calldata targets,
        uint256[] calldata values
    ) external returns (bool);
}

// File: contracts/strategies/TestStrategy.sol

pragma solidity 0.6.8;

// SPDX-License-Identifier: MIT

contract TestStrategy is IAscensionStrategy {
    event ProposalValidated();
    event ProposalExecuted();
    event ReceivedEth(address from, uint256 amount);

    receive() external payable {
        emit ReceivedEth(msg.sender, msg.value);
    }

    function validateProposal(
        address[] calldata _targets,
        uint256[] calldata _values
    ) external override returns (bool) {
        emit ProposalValidated();
        return true;
    }

    function executeStrategy(
        address[] calldata _targets,
        uint256[] calldata _values
    ) external override returns (bool) {
        emit ProposalExecuted();
        return true;
    }
}
