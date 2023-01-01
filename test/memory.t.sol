// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/memory.sol";

contract MemoryTest is Test {
  Memory mem;

  function setUp() external {
    mem = new Memory();
  }

  function test_freeMemPointer() external {
    (uint256 x, uint256 y) = mem.freeMemoryPointer();
    assertEq(x, 0x80);
    assertEq(y, 0x80 + 0x40);
  }

  function test_freeAbiEncode() external {
    (uint256 x, uint256 y) = mem.abiEncode();
    assertEq(x, 0x80);
    assertEq(y, 0x80 + 0x60);
  }

  function test_freeAbiEncodePacked() external {
    (uint256 x, uint256 y) = mem.abiEncodePacked();
    assertEq(x, 0x80);
    assertEq(y, 0x80 + 0x50);
  }  
  
  function test_args() external {
    uint256[] memory arr = new uint256[](2);
    arr[0] = 1;
    arr[1] = 2;
    (
      uint256 location,
      uint256 len,
      uint256 value0,
      uint256 value1
    ) = mem.args(arr);
    assertEq(location, 0x80);
    assertEq(len, 2);
    assertEq(value0, 1);
    assertEq(value1, 2);
  }

  function test_strings() external {
    (
      uint256 location,
      uint256 len,
      bytes32 value0,
      bytes32 value1
    ) = mem.strings("https://github.com/foundry-rs/foundry/tree/master/config");
    assertEq(location, 0x80);
    assertEq(len, 56);
    assertEq(value0, 0x68747470733a2f2f6769746875622e636f6d2f666f756e6472792d72732f666f);
    assertEq(value1, 0x756e6472792f747265652f6d61737465722f636f6e6669670000000000000000);
  }
}