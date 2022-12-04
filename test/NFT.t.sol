// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NFT.sol";

contract NFTsolmate is Test {
    NFT public nft;

    function setUp() public {
        nft = new NFT("top@secret1!");
    }

    function testMint() public {
        assertEq(nft.totalSupply(), 0);
        vm.deal(address(0xdead), 1 ether);
        vm.prank(address(0xdead));
        nft.mint{value: 0.1637 ether}(10);
        assertEq(nft.totalSupply(), 1);
    }
}
