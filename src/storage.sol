// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Storage {
  uint256 x; // slot 0
  // slot 1
  uint128 a = 1;
  uint64 b = 2;
  uint32 c = 3;
  uint16 d = 4;
  uint8 e = 5;
  uint8 f = 6;

  // arrays & maps
  uint256[3] fixedArray; // slot 2,3,4
  uint256[] dynamicArray; // slot 5

  constructor() {
    fixedArray = [9, 99, 999];
    dynamicArray = [1, 2, 3]; // slots keccak256(5) + 0, keccak256(5) + 1, keccak256(5) + 2
  }

  function getX() external view returns (uint256 ret) {
    assembly {
      ret := sload(x.slot)
    }
  }

  function setX(uint256 value) external {
    assembly {
      sstore(x.slot, value)
    }
  }

  function getSecondSlot() external view returns (bytes32 slot) {
    assembly {
      slot := sload(a.slot)
    }
  }

  function readE() external view returns (uint256 ret) {
    assembly {
      let shifted := shr(mul(e.offset, 8), sload(e.slot))
      ret := and(0xff, shifted)
    }
  }

  function setE(uint8 value) external {
    assembly {
      let slot := sload(e.slot) // 0x0605000400000003000000000000000200000000000000000000000000000001
      let nullifiedE := and(slot, 0xff00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
      let shiftedE := shl(mul(e.offset, 8), value) // 0x00ff000000000000000000000000000000000000000000000000000000000000
      let newE := or(nullifiedE, shiftedE)
      sstore(e.slot, newE)
    }
  }

  function getFixedArrayValue(uint256 index) external view returns (uint256 value) {
    assembly {
      let slot := fixedArray.slot
      value := sload(add(slot, index))
    }
  }

  function getDynamicArrayValue(uint256 index) external view returns (uint256 value) {
    uint256 slot;
    assembly {
      slot := dynamicArray.slot
    }
    bytes32 location = keccak256(abi.encode(slot));
    assembly {
      value := sload(add(location, index))
    }
  }
}