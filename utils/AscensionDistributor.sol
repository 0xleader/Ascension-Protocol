pragma solidity 0.6.8;

interface IERC20 {
  function transfer(address to, uint256 value) external;

  function transferFrom(
    address from,
    address to,
    uint256 value
  ) external;

  function balanceOf(address tokenOwner) external returns (uint256 balance);
}

contract AscensionDistributor {
  function airdropMultiValue(
    address _token,
    address[] memory _to,
    uint256[] memory _values
  ) public {
    require(_to.length == _values.length);
    for (uint256 i = 0; i < _to.length; i++) {
      IERC20(_token).transferFrom(msg.sender, _to[i], _values[i]);
    }
  }

  function airdropSingleValue(
    address _token,
    address[] memory _to,
    uint256 _value
  ) public {
    for (uint256 i = 0; i < _to.length; i++) {
      IERC20(_token).transferFrom(msg.sender, _to[i], _value);
    }
  }
}
