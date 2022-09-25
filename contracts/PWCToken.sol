// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract PWCToken is ERC20 {

    uint public constant TOKEN_PRICE = 0.01 ether;

    constructor(string memory name, string memory symbol) ERC20(name, symbol) {
        _mint(msg.sender, 100000 * (10 ** 18));
    }

    function buyTokens(uint _amount) public payable {
        require(msg.value == TOKEN_PRICE * _amount, "Incorrect ether amount sent.");
        _mint(msg.sender, _amount * (10 ** 18));
    }

    function sellTokens(uint _amount) public {
        _burn(msg.sender, _amount * (10 ** 18));
        uint ethToSend = _amount * TOKEN_PRICE;
        require(payable(msg.sender).send(ethToSend), "Transfer failed.");
    }

}
