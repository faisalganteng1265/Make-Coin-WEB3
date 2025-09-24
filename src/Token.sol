// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Token is ERC20 {

    address public owner;

    error Unauthorized();

    event Mint(address indexed to, uint256 amount);
    event Burned(address indexed from, uint256 amount);

    constructor(string memory _name, string memory _symbol) ERC20(_name, _symbol) {
        owner = msg.sender;
    }

    function mint(address to, uint256 amount)external onlyOwner {
        _mint(to, amount);

        emit Mint(to, amount);
    }

    function burn(address from, uint256 amount) external onlyOwner {
        _burn(from, amount);

        emit Burned(from, amount);
    }

               modifier onlyOwner() {
               _onlyOwner();
               _;
           }
           
           function _onlyOwner() internal view {
               if(msg.sender != owner) revert Unauthorized();
           }
}