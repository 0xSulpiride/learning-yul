// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/storage.sol";

contract StorageTest is Test {
  Storage strg;

  function setUp() external {
    strg = new Storage();
  }

  function test_x() external {
    assertEq(strg.getX(), 0);
    strg.setX(1);
    assertEq(strg.getX(), 1);
  }

  function test_slot() external {
    assertEq(strg.getSecondSlot(), 0x0605000400000003000000000000000200000000000000000000000000000001);
  }

  function test_readE() external {
    assertEq(strg.readE(), 5);
  }

  function test_setE() external {
    strg.setE(16);
    assertEq(strg.readE(), 16);
    assertEq(strg.getSecondSlot(), 0x0610000400000003000000000000000200000000000000000000000000000001);
  }

  function test_fixedArray() external {
    assertEq(strg.getFixedArrayValue(0), 9);
    assertEq(strg.getFixedArrayValue(1), 99);
    assertEq(strg.getFixedArrayValue(2), 999);
  }

  function test_dynamicArray() external {
    assertEq(strg.getDynamicArrayValue(0), 1);
    assertEq(strg.getDynamicArrayValue(1), 2);
    assertEq(strg.getDynamicArrayValue(2), 3);
  }
}