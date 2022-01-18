// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

contract Employees {
  string fullname;

  constructor() public {
    fullname = "hello";
  }

  function setEmployee(string memory str) public  {
    fullname = str;
  }

  function getEmployee() public view returns (string memory) {
   return fullname;
  }

}
