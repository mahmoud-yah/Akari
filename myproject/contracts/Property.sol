// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import './Person.sol';

contract Property{

        Person owner;
        uint256 propertyNumber;
        bool status=false;

        constructor(uint256 propertyNum) public {
              owner = new Person("sads" , "fdg" , "sdfg" , "hfg" , 23);
            //  changePerson(o);
            propertyNumber = propertyNum;
            status = true;
        }

        function changeOwner(Person newOwner) public{
                owner.setFirstName(newOwner.getFirstName());
                owner.setLastName(newOwner.getLastName());
                owner.setFatherName(newOwner.getFatherName());
                owner.setMotherName(newOwner.getMotherName());
                owner.setNationalNumber(newOwner.getNationalNumber());
        }

        function getStatus() public view returns (bool){
            return status;
        }

        function getOwnerFullName() public view returns(string memory){
            return owner.getFullName();
        }

        function getOwnerID() public view returns (uint256){
            return owner.getNationalNumber();
        }

        function getPropertyAddress() public view returns(address){
            return address(this);
        }

        function getPropertyNumber() public view returns(uint256){
            return propertyNumber;
        }

}