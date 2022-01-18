//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.21 <0.7.0;

contract Person{
         string firstname;
        string lastname;
        string mothername;
        string fathername;
        string fullName;
        uint256 nationalNumber;

        constructor(string memory fn, string memory ln, string memory mn, string memory father_name,uint256 ID) public{
            fathername = fn;
            lastname = ln;
            mothername = mn;
            fathername = father_name;
            nationalNumber = ID;
            fullName = string (abi.encodePacked(firstname,lastname));
        }


        function setFirstName(string memory FN) public{
         firstname = FN;
        }
        function getFirstName() public view returns(string memory){
            return firstname;
        }

        function test() public pure returns(string memory){
            return "My name is Mahmoud";
        }

        function getFullName() public view returns(string memory){
            return fullName;
        }

         function setLastName(string memory LN) public{
         lastname = LN;
        }
        function getLastName() public view returns(string memory){
            return lastname;
        }

         function setFatherName(string memory FatherN) public{
         fathername = FatherN;
        }
        function getFatherName() public view returns(string memory){
            return fathername;
        }

         function setMotherName(string memory MN) public{
         mothername = MN;
        }
        function getMotherName() public view returns(string memory){
            return mothername;
        }

         function setNationalNumber(uint256 NatNum) public{
         nationalNumber = NatNum;
        }
        function getNationalNumber() public view returns(uint256){
            return nationalNumber;
        }

        function getInfo() public view returns(
        string memory,
        string memory,
        string memory,
        string memory,
        uint){
            return (firstname,lastname,fathername,mothername,nationalNumber);
        }

        function setInfo(
        string memory first_name,
        string memory last_name,
        string memory father_name,
        string memory mother_name,
        uint256 national_number
         ) public {
            firstname = first_name;
            lastname = last_name;
            fathername = father_name;
            mothername = mother_name;
            nationalNumber = national_number;

        }


}