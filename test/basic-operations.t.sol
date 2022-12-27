// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/basic-operations.sol";

contract BasicOperationsTest is Test {
  BasicOperations basicOps;

  function setUp() external {
    basicOps = new BasicOperations();
  }

  function test_isPrime() external {  
    assertTrue(basicOps.isPrime(1));
    assertTrue(basicOps.isPrime(3));
    assertTrue(basicOps.isPrime(5));
    assertTrue(basicOps.isPrime(7));
    assertTrue(basicOps.isPrime(11));
    assertTrue(basicOps.isPrime(13));
    assertTrue(basicOps.isPrime(97));
    assertFalse(basicOps.isPrime(2));
    assertFalse(basicOps.isPrime(4));
    assertFalse(basicOps.isPrime(6));
    assertFalse(basicOps.isPrime(8));
    assertFalse(basicOps.isPrime(12));
    assertFalse(basicOps.isPrime(1404));
    assertFalse(basicOps.isPrime(1000000));
    assertFalse(basicOps.isPrime(1010104));
  }
}