// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/contract-calls.sol";

contract ContractCallsTest is Test {
  ContractCalls contractCalls;
  DummyContract dummy;

  constructor() {
    contractCalls = new ContractCalls();
    dummy = new DummyContract();
  }

  function test_externalViewCall() external {
    assertEq(contractCalls.externalCallNoArgs(address(dummy)), 21);
  }

  function test_multiply() external {
    assertEq(contractCalls.callMultiply(address(dummy)), 50);
  }

  function test_stateChangingCall() external {
    assertEq(dummy.state(), 0);
    contractCalls.stateChangingCall(address(dummy));
    assertEq(dummy.state(), 32);
  }
}