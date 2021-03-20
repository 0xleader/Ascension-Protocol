// File: @openzeppelin/contracts/utils/Context.sol

// SPDX-License-Identifier: MIT

pragma solidity =0.6.8;
pragma experimental ABIEncoderV2;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
  function _msgSender() internal view virtual returns (address payable) {
    return msg.sender;
  }

  function _msgData() internal view virtual returns (bytes memory) {
    this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
    return msg.data;
  }
}

// File: @openzeppelin/contracts/access/Ownable.sol

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
  address private _owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev Initializes the contract setting the deployer as the initial owner.
   */
  constructor() internal {
    address msgSender = _msgSender();
    _owner = msgSender;
    emit OwnershipTransferred(address(0), msgSender);
  }

  /**
   * @dev Returns the address of the current owner.
   */
  function owner() public view virtual returns (address) {
    return _owner;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(owner() == _msgSender(), "Ownable: caller is not the owner");
    _;
  }

  /**
   * @dev Leaves the contract without owner. It will not be possible to call
   * `onlyOwner` functions anymore. Can only be called by the current owner.
   *
   * NOTE: Renouncing ownership will leave the contract without an owner,
   * thereby removing any functionality that is only available to the owner.
   */
  function renounceOwnership() public virtual onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
   * Can only be called by the current owner.
   */
  function transferOwnership(address newOwner) public virtual onlyOwner {
    require(newOwner != address(0), "Ownable: new owner is the zero address");
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}

// File: @openzeppelin/contracts/math/SafeMath.sol

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
  /**
   * @dev Returns the addition of two unsigned integers, with an overflow flag.
   *
   * _Available since v3.4._
   */
  function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
    uint256 c = a + b;
    if (c < a) return (false, 0);
    return (true, c);
  }

  /**
   * @dev Returns the substraction of two unsigned integers, with an overflow flag.
   *
   * _Available since v3.4._
   */
  function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
    if (b > a) return (false, 0);
    return (true, a - b);
  }

  /**
   * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
   *
   * _Available since v3.4._
   */
  function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
    if (a == 0) return (true, 0);
    uint256 c = a * b;
    if (c / a != b) return (false, 0);
    return (true, c);
  }

  /**
   * @dev Returns the division of two unsigned integers, with a division by zero flag.
   *
   * _Available since v3.4._
   */
  function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
    if (b == 0) return (false, 0);
    return (true, a / b);
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
   *
   * _Available since v3.4._
   */
  function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
    if (b == 0) return (false, 0);
    return (true, a % b);
  }

  /**
   * @dev Returns the addition of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `+` operator.
   *
   * Requirements:
   *
   * - Addition cannot overflow.
   */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");
    return c;
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   *
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b <= a, "SafeMath: subtraction overflow");
    return a - b;
  }

  /**
   * @dev Returns the multiplication of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `*` operator.
   *
   * Requirements:
   *
   * - Multiplication cannot overflow.
   */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    if (a == 0) return 0;
    uint256 c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");
    return c;
  }

  /**
   * @dev Returns the integer division of two unsigned integers, reverting on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   *
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b > 0, "SafeMath: division by zero");
    return a / b;
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * reverting when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   *
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    require(b > 0, "SafeMath: modulo by zero");
    return a % b;
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
   * overflow (when the result is negative).
   *
   * CAUTION: This function is deprecated because it requires allocating memory for the error
   * message unnecessarily. For custom revert reasons use {trySub}.
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   *
   * - Subtraction cannot overflow.
   */
  function sub(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
    require(b <= a, errorMessage);
    return a - b;
  }

  /**
   * @dev Returns the integer division of two unsigned integers, reverting with custom message on
   * division by zero. The result is rounded towards zero.
   *
   * CAUTION: This function is deprecated because it requires allocating memory for the error
   * message unnecessarily. For custom revert reasons use {tryDiv}.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   *
   * - The divisor cannot be zero.
   */
  function div(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
    require(b > 0, errorMessage);
    return a / b;
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * reverting with custom message when dividing by zero.
   *
   * CAUTION: This function is deprecated because it requires allocating memory for the error
   * message unnecessarily. For custom revert reasons use {tryMod}.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   *
   * - The divisor cannot be zero.
   */
  function mod(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
    require(b > 0, errorMessage);
    return a % b;
  }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address owner, address spender) external view returns (uint256);

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external returns (bool);

  /**
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) external returns (bool);

  /**
   * @dev Emitted when `value` tokens are moved from one account (`from`) to
   * another (`to`).
   *
   * Note that `value` may be zero.
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
   * a call to {approve}. `value` is the new allowance.
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

// File: contracts/interfaces/IAscension.sol

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

// File: contracts/interfaces/IAscensionStrategy.sol

interface IAscensionStrategy {
  function validateProposal(address[] calldata targets, uint256[] calldata values)
    external
    returns (bool);

  function executeStrategy(address[] calldata targets, uint256[] calldata values)
    external
    returns (bool);
}

// File: contracts/AscensionDAO.sol

//VERSION 1.1.0
// Original work from Compound: https://github.com/compound-finance/compound-protocol/blob/master/contracts/Governance/GovernorAlpha.sol
// all votes work on underlying checkpoints[address], not balanceOf(address)

contract AscensionDAO is Ownable {
  using SafeMath for uint256;

  //NAME of contract
  string public name = "Ascension DAO";
  string public VERSION = "1.2.0";

  //Active bool
  bool public active;

  // ASCEND token interface
  IAscension private Ascend;

  //approved strategies for proposal
  mapping(address => bool) public approvedStrategies;

  // The proposal struct
  struct Proposal {
    uint256 id;
    uint256 startBlock;
    uint256 endBlock;
    uint256 votesFor;
    uint256 votesAgainst;
    uint256[] values;
    address proposedBy;
    address payable strategy;
    address[] targets;
    mapping(address => Receipt) receipts;
    bool canceled;
    bool executed;
  }

  //the receipt struct
  struct Receipt {
    bool hasVoted;
    bool support;
    uint256 votes;
  }

  //the proposals mapping and counter
  mapping(uint256 => Proposal) public proposals;
  uint256 public proposalCount;

  /// @notice Possible states that a proposal may be in
  enum ProposalState { Pending, Active, Canceled, Defeated, Succeeded, Executed }

  // tracks the latest proposal created by a user, only 1 active proposal at a time
  mapping(address => uint256) private latestIds;

  //minimum votes required to enact a proposal
  uint256 public requiredVotes;

  //minimum level required to create a proposal
  uint8 public proposalLevel;

  //delay before proposal is active
  uint256 public delay;

  //period in blocks that a proposal is active
  uint256 public votingPeriod;

  /// @notice The EIP-712 typehash for the contract's domain
  bytes32 public constant DOMAIN_TYPEHASH =
    keccak256("EIP712Domain(string name,uint256 chainId,address verifyingContract)");

  /// @notice The EIP-712 typehash for the ballot struct used by the contract
  bytes32 public constant BALLOT_TYPEHASH = keccak256("Ballot(uint256 Id,bool support)");

  //MODIFIERS-------------------------------------------
  modifier requireLevel(uint8 _level) {
    require(Ascend.getLevel(msg.sender) >= _level);
    _;
  }

  modifier requireActive() {
    require(active);
    _;
  }

  //EVENTS-----------------------------------------------
  event ProposalCreated(
    uint256 id,
    address creator,
    address payable strategy,
    address[] targets,
    uint256[] values,
    uint256 startBlock,
    uint256 endBlock,
    string description
  );
  event ProposalExecuted(uint256 Id);
  event ProposalCanceled(uint256 Id);
  event voteCast(uint256 Id, address voter, bool support, uint256 votes);

  //CONSTRUCTOR-----------------------------------------
  constructor(address _token) public {
    Ascend = IAscension(_token);

    //Default values
    delay = 0;
    votingPeriod = 10000;
    proposalLevel = 3;
    requiredVotes = 144000e9;
    active = true;
  }

  //EXTERNAL OWNER FUNCTIONS-------------------------------------
  function approveStrategy(address payable _strategy) external onlyOwner() {
    require(
      !approvedStrategies[_strategy],
      "Ascension DAO:approveStrategy: strategy is already approved!"
    );
    approvedStrategies[_strategy] = true;
  }

  function removeStrategy(address payable _strategy) external onlyOwner() {
    require(
      approvedStrategies[_strategy],
      "Ascension DAO:removeStrategy: strategy is not yet approved!"
    );
    approvedStrategies[_strategy] = false;
  }

  function setProposalLevel(uint8 _level) external onlyOwner() {
    require(_level <= 9, "Ascension DAO:setProposalLevel: Only 9 Ascension Levels!");
    proposalLevel = _level;
  }

  function setRequiredVotes(uint256 _value) external onlyOwner() {
    requiredVotes = _value;
  }

  function setDelay(uint256 _delay) external onlyOwner() {
    delay = _delay;
  }

  function setVotingPeriod(uint256 _period) external onlyOwner() {
    votingPeriod = _period;
  }

  function setActive(bool _value) external onlyOwner() {
    active = _value;
  }

  function cancel(uint256 proposalId) external onlyOwner() {
    ProposalState currentState = state(proposalId);
    require(
      currentState != ProposalState.Executed,
      "Ascension DAO::cancel: cannot cancel executed proposal"
    );

    Proposal storage proposal = proposals[proposalId];

    proposal.canceled = true;

    emit ProposalCanceled(proposalId);
  }

  //EXTERNAL FUNCTIONS---------------------------------------------------------------------------------------------------
  function state(uint256 Id) public view returns (ProposalState) {
    require(proposalCount >= Id && Id > 0, "Ascension DAO:state: invalid proposal id");
    Proposal storage proposal = proposals[Id];
    if (proposal.canceled) {
      return ProposalState.Canceled;
    } else if (proposal.executed) {
      return ProposalState.Executed;
    } else if (block.number < proposal.startBlock) {
      return ProposalState.Pending;
    } else if (
      block.number <= proposal.endBlock &&
      proposal.votesFor < requiredVotes &&
      proposal.votesAgainst < requiredVotes
    ) {
      return ProposalState.Active;
    } else if (proposal.votesFor <= proposal.votesAgainst || proposal.votesFor <= requiredVotes) {
      return ProposalState.Defeated;
    } else {
      return ProposalState.Succeeded;
    }
  }

  function propose(
    address payable _strategy,
    address[] calldata _targets,
    uint256[] calldata _values,
    string calldata _description
  ) external requireLevel(proposalLevel) requireActive() {
    //check that the strategy address is approved
    require(
      approvedStrategies[_strategy],
      "Ascension DAO:propose: Input address is not an approved strategy!"
    );
    require(
      _targets.length == _values.length,
      "Ascension DAO:propose: Must be one target per value!"
    );

    // check that proposer does not have an active proposal
    uint256 latestId = latestIds[msg.sender];
    if (latestId > 0) {
      ProposalState proposersLatestProposalState = state(latestId);
      require(
        proposersLatestProposalState != ProposalState.Active,
        "Ascension DAO:propose: one live proposal per proposer, found an already active proposal"
      );
      require(
        proposersLatestProposalState != ProposalState.Pending,
        "Ascension DAO:propose: one live proposal per proposer, found an already pending proposal"
      );
    }
    //check that inputs are valid for strategy
    require(
      IAscensionStrategy(_strategy).validateProposal(_targets, _values),
      "AScension DAO:propose: the provided targets and/or values are not valid for this strategy."
    );

    //get block numbers for start and end block
    uint256 startBlock = SafeMath.add(block.number, delay);

    //+1 proposal counter
    proposalCount++;

    //initialize proposal object
    Proposal memory newProposal =
      Proposal({
        id: proposalCount,
        proposedBy: msg.sender,
        startBlock: startBlock,
        endBlock: SafeMath.add(startBlock, votingPeriod),
        strategy: _strategy,
        targets: _targets,
        values: _values,
        votesFor: 0,
        votesAgainst: 0,
        canceled: false,
        executed: false
      });

    //set proposal
    proposals[newProposal.id] = newProposal;
    //update users latest proposal id
    latestIds[newProposal.proposedBy] = newProposal.id;

    emit ProposalCreated(
      newProposal.id,
      msg.sender,
      _strategy,
      _targets,
      _values,
      startBlock,
      newProposal.endBlock,
      _description
    );
  }

  function vote(uint256 _proposalId, bool _support) external {
    return _vote(msg.sender, _proposalId, _support);
  }

  function execute(uint256 _proposalId) external requireLevel(proposalLevel) requireActive() {
    require(
      state(_proposalId) == ProposalState.Succeeded,
      "Ascension DAO:execute: proposal can only be executed if it has succeeded"
    );

    Proposal storage proposal = proposals[_proposalId];

    //proposal is executed
    proposal.executed = true;

    //call ascension event
    Ascend.ascensionEvent(proposal.strategy, proposal.targets, proposal.values);

    emit ProposalExecuted(_proposalId);
  }

  function voteBySig(
    uint256 proposalId,
    bool support,
    uint8 v,
    bytes32 r,
    bytes32 s
  ) public {
    bytes32 domainSeparator =
      keccak256(abi.encode(DOMAIN_TYPEHASH, keccak256(bytes(name)), getChainId(), address(this)));

    bytes32 structHash = keccak256(abi.encode(BALLOT_TYPEHASH, proposalId, support));

    bytes32 digest = keccak256(abi.encodePacked("\x19\x01", domainSeparator, structHash));

    address signatory = ecrecover(digest, v, r, s);
    require(signatory != address(0), "Ascension DAO::voteBySig: invalid signature");
    return _vote(signatory, proposalId, support);
  }

  //VIEW ONLY FUNCTIONS------------------------------------------------------------------

  function getReceipt(uint256 _proposalId, address _voter) public view returns (Receipt memory) {
    return proposals[_proposalId].receipts[_voter];
  }

  function getActions(uint256 _proposalId)
    public
    view
    returns (
      address payable strategy,
      address[] memory targets,
      uint256[] memory values
    )
  {
    Proposal storage p = proposals[_proposalId];
    return (p.strategy, p.targets, p.values);
  }

  //INTERNAL FUNCTIONS---------------------------------------------------------------------

  function _vote(
    address _voter,
    uint256 _proposalId,
    bool _support
  ) internal requireActive() {
    //require active proposal
    require(
      state(_proposalId) == ProposalState.Active,
      "Ascension DAO:_vote: voting is currently closed"
    );

    //proposal and receipt object
    Proposal storage proposal = proposals[_proposalId];
    Receipt storage receipt = proposal.receipts[_voter];

    //require user has not voted
    require(receipt.hasVoted == false, "Ascension DAO:_vote: user has already voted");

    //get prior votes for startBlock
    uint256 votes = Ascend.getPriorValue(msg.sender, proposals[_proposalId].startBlock);

    //add votes to proposal based on support
    if (_support) {
      proposal.votesFor = SafeMath.add(proposal.votesFor, votes);
    } else {
      proposal.votesAgainst = SafeMath.add(proposal.votesAgainst, votes);
    }

    //create receipt
    receipt.hasVoted = true;
    receipt.support = _support;
    receipt.votes = votes;

    emit voteCast(_proposalId, msg.sender, _support, votes);
  }

  function getChainId() internal pure returns (uint256) {
    uint256 chainId;
    assembly {
      chainId := chainid()
    }
    return chainId;
  }

  //--------------------------------------------------------------------------------------------------------------------
}
