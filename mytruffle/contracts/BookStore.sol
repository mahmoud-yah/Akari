// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

contract BookStore{
    address sender;
    string fullname;
    string description;
    uint price;
    function sellBook(string memory _fullname,string memory _description,uint _price) public{
        sender = msg.sender;
        fullname = _fullname;
        description = _description;
        price = _price;
    }

    function getBook() public view returns(
        address _sender,
        string memory _fullname,
        string memory _description,
        uint _price
    )
    {
        return(sender,fullname,description,price);
    }
}