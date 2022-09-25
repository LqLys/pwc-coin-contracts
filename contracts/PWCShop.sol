// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract PWCShop is Ownable {

    struct Ticket {
        uint id;
        address owner;
        uint price;
        bool forSale;
        bool valid;
    }

    IERC20 pwcTokenContract;
    uint public constant TOKEN_PRICE = 0.01 ether;
    uint private idCounter = 0;
    mapping(uint => Ticket) public items;


    constructor(address _pwcTokenAddress){
        pwcTokenContract = IERC20(_pwcTokenAddress);
    }


    function addToShop(uint _amount, uint _price) public onlyOwner {
        for(uint i = 0; i < _amount; i++){
            Ticket memory item = Ticket(idCounter, address(this), _price, true, true);
            items[idCounter] = item;
            idCounter++;
        }
    }

    function toggleSaleStatus(uint _itemId) public {
        Ticket storage item = items[_itemId];
        require(item.owner == msg.sender, "Not a token owner.");
        item.forSale = !item.forSale;

    }

    function buyTicket(uint _tokenId) public {
        Ticket storage item = items[_tokenId];

        require(item.forSale, "Item is not for sale.");
        require(pwcTokenContract.balanceOf(msg.sender) >= item.price, "Not enough balance.");
        pwcTokenContract.transferFrom(msg.sender, item.owner, item.price);
        item.owner = msg.sender;
        item.forSale = false;
    }

    function setForSale(uint _tokenId, uint _price) public {
        Ticket storage item = items[_tokenId];
        require(item.owner == msg.sender, "Not a token owner.");
        item.forSale = true;
        item.price = _price;
    }


    function getTickets() public view returns(Ticket[] memory){
        Ticket[] memory tickets = new Ticket[](idCounter);
        for(uint i = 0; i < idCounter ; i++){
            tickets[i] = items[i];
        }
        return tickets;
    }

}
