// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract YulTypes {
  function getNumber() external pure returns (uint256)
  {
    uint256 x;
    assembly {
      x := 42
    }
    return x;
  }

  function getHex() external pure returns (uint256)
  {
    uint256 x;
    assembly {
      x := 0xa
    }
    return x;
  }

  function getString() external pure returns (string memory)
  {
    bytes32 myString;
    assembly {
      myString := "Hello World"
    }
    return string(abi.encode(myString));
  }
}