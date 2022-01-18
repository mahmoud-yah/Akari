// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

import './Person.sol';
import './Property.sol';

contract Main{

        string firstname;
        string lastname;
        string mothername;
        string fathername;
        uint256 nationalNumber;
        uint256 blockNumber;
        uint256 constant NULL = 0;
        string state = "none";
        Person buyer;
        Person seller;

        mapping(uint256=>Property) contracts;
        mapping(uint256=>bool) checker;

     function setProperty(Property p) private {
         contracts[p.getPropertyNumber()] = p;
         checker[p.getPropertyNumber()] = true;
     }

     function getState() public view returns(string memory){
         return state;
     }


    //  function checkProperty(uint256 blockNumber) public view returns(bool){
    //         if(contracts[blockNumber].getStatus())
    //             return true;
    //             else return false;
    //     }

        function setBlockNumber(uint256 BN) public {
            blockNumber = BN;
        }

        function getOwnerNationalNumber(uint256 BN) public view returns(uint256){
            if(checker[BN]==true)
                {
                    return contracts[BN].getOwnerID();
                }
        }

        function setBuyerInfo(
        string memory First_Name,
        string memory Last_Name,
        string memory Father_Name,
        string memory Mother_Name,
        uint256 ID)
         public {
         firstname = First_Name;
         lastname = Last_Name;
         fathername = Father_Name;
         mothername = Mother_Name;
         nationalNumber = ID;
         buyer = new Person(firstname,lastname,fathername,mothername,nationalNumber);

        }

        function setSellerInfo(
        string memory First_Name,
        string memory Last_Name,
        string memory Father_Name,
        string memory Mother_Name,
        uint256 ID)
         public {
         firstname = First_Name;
         lastname = Last_Name;
         fathername = Father_Name;
         mothername = Mother_Name;
         nationalNumber = ID;
         seller = new Person(firstname,lastname,fathername,mothername,nationalNumber);

        }


        function change_Owner() public returns(string memory){
        if(checker[blockNumber]==true){
            state = "found the Property and changed the owner";
            contracts[blockNumber].changeOwner(buyer);
        }
        else{
             Property p = new Property(blockNumber);
             p.changeOwner(seller);
             setProperty(p);
              p.changeOwner(buyer);
            //contracts[blockNumber].changeOwner(buyer);
             state = "Added to the properties map, and then changed the owner";
        }

            return state;
        }

        // function change_Owner() public view returns(string memory){
        //  //checkProperty();
        //  return getState();
        // }


        // function getOwnerValues() view public returns(uint){
        //   return o.getNationalNumber();//(abi.encodePacked(o.getFirstName,o.getLastName,o.getFatherName,o.getMotherName));
        // }
}