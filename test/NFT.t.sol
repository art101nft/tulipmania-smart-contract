// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NFT.sol";

contract NFTsolmate is Test {
    NFT public nft;

    function setUp() public {
        nft = new NFT("test", "test");
    }

    function testMint() public {
        assertEq(nft.totalSupply(), 0);
        vm.prank(address(0xdead));
        nft.mint();
        assertEq(nft.totalSupply(), 1);
    }
}
