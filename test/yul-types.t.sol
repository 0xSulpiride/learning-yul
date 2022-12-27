// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/yul-types.sol";

contract YulTypesTest is Test {
  YulTypes yulTypes;
  function setUp() external {
    yulTypes = new YulTypes();
  }

  function test_uint256() external {
    assertEq(yulTypes.getNumber(), 42);
  }

  function test_hex() external {
    assertEq(yulTypes.getHex(), 10);
  }

  function test_string() external {
    // TODO
  }
}