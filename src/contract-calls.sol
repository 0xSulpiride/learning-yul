// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract DummyContract {
  uint256 public state;
  function get21() external pure returns (uint256) {
    return 21;
  }

  function multiply(uint128 x, uint32 y) external pure returns (uint256) {
    return x * y;
  }

  function setState(uint256 y) external {
    state = y;
  }
}

contract ContractCalls {
  function externalCallNoArgs(address _a)
    external
    view
    returns (uint256)
  {
    // bytes32 hash = keccak256("get21()");
    assembly {
      // mstore(0x00, shr(112, hash))
      mstore(0x00, 0x9a884bde)
      let success := staticcall(gas(), _a, 28, 32, 0x00, 0x20)
      if iszero(success) {
        revert(0, 0)
      }

      return (0x00, 0x20)
    }
  }

  function callMultiply(address _a)
    external
    view
    returns (uint256)
  {
    assembly {
      let mptr := mload(0x40)
      mstore(mptr, 0x66caa861)
      mstore(add(mptr, 0x20), 5)
      mstore(add(mptr, 0x40), 10)
      mstore(0x40, add(mptr, 0x60))
      let success := staticcall(gas(), _a, add(mptr, 28), mload(0x40), 0x00, 0x20)
      if iszero(success) {
        revert(0, 0)
      }
      return (0x00, 0x20)
    }
  }

  function stateChangingCall(address _a)
    external
    payable
  {
    assembly {
      let mptr := mload(0x40)
      mstore(mptr, 0xa9e966b7)
      mstore(add(mptr, 0x20), 32)
      mstore(0x40, add(mptr, 0x40))
      let success := call(gas(), _a, callvalue(), add(mptr, 28), 0x40, 0x00, 0x00)
      if iszero(success) {
        revert(0, 0)
      }
      return (0x00, 0x00)
    }
  }
}
