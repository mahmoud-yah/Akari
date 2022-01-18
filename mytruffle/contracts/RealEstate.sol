//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.4.21 <0.7.0;

contract Owner{
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

}

contract Property{

        Owner owner;
        uint256 propertyNumber;
        bool status=false;

        constructor(uint256 propertyNum) public {
              owner = new Owner("sads" , "fdg" , "sdfg" , "hfg" , 23);
            //  changeOwner(o);
            propertyNumber = propertyNum;
            status = true;
        }

        function changeOwner(Owner newOwner) public{
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


contract Main{

        string firstname;
        string lastname;
        string mothername;
        string fathername;
        uint256 nationalNumber;
        uint256 blockNumber;
        uint256 constant NULL = 0;
        string state = "none";
        Owner buyer;
        Owner seller;

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

        function getOwnerNationalNumner(uint256 BN) public view returns(uint256){
            if(checker[BN]==true)
                {
                    return contracts[BN].getOwnerID();
                }
        }

        function setBuyerInfo(string memory First_Name,string memory Last_Name,string memory Father_Name,string memory Mother_Name,uint256 ID)
         public {
         firstname = First_Name;
         lastname = Last_Name;
         fathername = Father_Name;
         mothername = Mother_Name;
         nationalNumber = ID;
         buyer = new Owner(firstname,lastname,fathername,mothername,nationalNumber);

        }

        function setSellerInfo(string memory First_Name,string memory Last_Name,string memory Father_Name,string memory Mother_Name,uint256 ID)
         public {
         firstname = First_Name;
         lastname = Last_Name;
         fathername = Father_Name;
         mothername = Mother_Name;
         nationalNumber = ID;
         seller = new Owner(firstname,lastname,fathername,mothername,nationalNumber);

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