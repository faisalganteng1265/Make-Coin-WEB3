// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "forge-std/Test.sol";
import {Token} from "../src/Token.sol";

contract TokenTest is Test {
    Token token;
    address public owner = makeAddr("owner");
    address public user1 = makeAddr("user1");

    function setUp() public {
        vm.startPrank(owner);
        token = new Token("MyToken", "MTK");
        vm.stopPrank();
    }

    function testInitialSupply() public view {
        assertEq(token.name(), "MyToken");
        assertEq(token.symbol(), "MTK");
        assertEq(token.totalSupply(), 0);
        assertEq(token.balanceOf(owner), 0);
    }

    function testMint() public {
        uint256 mintAmount = 1000;
        vm.startPrank(owner);
        token.mint(user1, mintAmount);
        vm.stopPrank();

        assertEq(token.balanceOf(user1), mintAmount);
        assertEq(token.totalSupply(), mintAmount);
    }

    function testUnauthorizedMint() public {
        vm.startPrank(user1);
        vm.expectRevert(Token.Unauthorized.selector);
        token.mint(user1, 1000);
        vm.stopPrank();
    }
}