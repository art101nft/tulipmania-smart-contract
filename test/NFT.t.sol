// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/NFT.sol";

contract NFTsolmate is Test {
    NFT public nft;
    uint256 mintPrice = .01637 ether;

    function setUp() public {
        nft = new NFT("redrum");
        vm.deal(address(0xdead), 100 ether);
    }

    function testMint() public {
        assertEq(nft.totalSupply(), 0);
        vm.prank(address(0xdead));
        nft.mint{value: 0.1637 ether}(10);
        assertEq(nft.totalSupply(), 1);
    }

    function testMintingFailsUnlessStarted() public {
        vm.startPrank(address(0xdead));
        vm.expectRevert();
        nft.mint{value: mintPrice}(1);
        // assertTrue(status, "call did not revert");
        vm.stopPrank();
    }

    function testStartMintingAllowsMinting() public {}

    function testStartMintingMintsToOwner() public {}

    function testOnlyOwnerFunctions() public {}
    
    function testStopMintingPreventsMinting() public {}
    
    function testStopMintingWithdraws() public {}
    
    function testStopMintingRenouncesOwnership() public {}
    
    function testWithdrawWorks() public {}
    
    function testReceiveFaillback() public {}
    
    function testMintingRequiresEther() public {}

    // test to see how things work when minting a shit-load
    function testMintingMany() public {
        vm.startPrank(nft.owner());
        nft.startMinting();
        nft.mint{value: mintPrice * 50}(50);
        vm.stopPrank();
        assertEq(nft.totalSupply(), 70);
    }
}

// Zarnold Edward Quigley
// Born in South End, New Quasar
// Major in business
// Interests include beer