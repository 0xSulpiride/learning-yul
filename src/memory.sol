// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

contract Memory {
  struct SomeStruct {
    uint256 x;
    uint256 y;
  }

  function freeMemoryPointer() external pure returns (uint256 x, uint256 y) {
    uint256 x40;
    assembly {
      x40 := mload(0x40)
    }
    x = x40;
    SomeStruct memory s = SomeStruct(1, 2);
    assembly {
      x40 := mload(0x40)
    }
    y = x40;
  }

  function abiEncode() external pure returns (uint256 x, uint256 y) {
    uint256 x40;
    assembly {
      x40 := mload(0x40)
    }
    x = x40;
    abi.encode(uint256(0), uint128(1));
    assembly {
      x40 := mload(0x40)
    }
    y = x40;
  }

  function abiEncodePacked() external pure returns (uint256 x, uint256 y) {
    uint256 x40;
    assembly {
      x40 := mload(0x40)
    }
    x = x40;
    abi.encodePacked(uint256(0), uint128(1));
    assembly {
      x40 := mload(0x40)
    }
    y = x40;
  }

  function args(uint256[] memory arr)
    external
    pure
    returns (
      uint256 location,
      uint256 len,
      uint256 value0,
      uint256 value1
    )
  {
    assembly {
      location := arr
      len := mload(location)
      value0 := mload(add(location, 0x20))
      value1 := mload(add(location, 0x40))
    }
  }

  function strings(string memory str)
    external
    pure
    returns (
      uint256 location,
      uint256 len,
      bytes32 value0,
      bytes32 value1
    )
  {
    assembly {
      location := str
      len := mload(location)
      value0 := mload(add(location, 0x20))
      value1 := mload(add(location, 0x40))
    } 
  }
}