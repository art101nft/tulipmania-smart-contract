// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TulipMania.sol";

contract NFTsolmate is Test {
    event Transfer(address indexed from, address indexed to, uint256 amount);

    TulipMania public nft;
    uint256 mp;
    uint256 oma;
    address og;
    address o = address(0xdead);
    address t = address(0xbeef);

    function setUp() public {
        nft = new TulipMania("redrum");
        og = nft.deployer();
        nft.transferOwnership(o);
        mp = nft.mintPrice();
        oma = nft.ownerMintAmount();
    }

    function testFailMintingFailsUnlessStarted() public {
        assertEq(nft.totalSupply(), 0);
        assertEq(nft.mintingAllowed(), false);
        hoax(t);
        nft.mint{value: mp}(1);
    }

    function testStartMintingAllowsMinting() public {
        assertEq(nft.mintingAllowed(), false);
        hoax(o);
        nft.startMinting();
        assertEq(nft.mintingAllowed(), true);
    }

    function testMintingMany() public {
        hoax(o);
        nft.startMinting();
        hoax(t);
        nft.mint{value: mp * 80}(80);
        assertEq(nft.totalSupply(), 80);
    }

    function testOwnerMint() public {
        startHoax(o);
        nft.startMinting();
        assertEq(nft.totalSupply(), 0);
        assertEq(nft.balanceOf(o), 0);
        nft.ownerMint();
        assertEq(nft.totalSupply(), oma);
        assertEq(nft.balanceOf(o), oma);
    }

    function testOnlyOwnerFunctions() public {
        startHoax(t);
        vm.expectRevert(bytes("Ownable: caller is not the owner"));
        nft.startMinting();
        vm.expectRevert(bytes("Ownable: caller is not the owner"));
        nft.stopMinting();
        vm.expectRevert(bytes("Ownable: caller is not the owner"));
        nft.withdraw();
    }
    
    function testStopMintingPreventsMinting() public {
        startHoax(o);
        nft.startMinting();
        nft.stopMinting();
        assertEq(nft.mintingAllowed(), false);
        vm.expectRevert(bytes("minting not allowed"));
        nft.mint{value: mp}(1);
    }
    
    function testStopMintingWithdraws() public {
        hoax(o);
        nft.startMinting();
        hoax(t);
        nft.mint{value: mp * 10}(10);
        assertEq(address(nft).balance, mp * 10);
        hoax(o, 1 ether);
        nft.stopMinting();
        assertEq(address(nft).balance, 0);
        assertEq(address(o).balance, 1 ether + mp * 10);
    }

    function testCannotStartMintingTwice() public {
        startHoax(o);
        nft.startMinting();
        nft.stopMinting();
        vm.expectRevert();
        nft.startMinting();
    }

    function testOwnerCannotMintTwice() public {
        startHoax(o);
        nft.ownerMint();
        vm.expectRevert(bytes("owner already minted"));
        nft.ownerMint();
    }
    
    function testStopMintingRenouncesOwnership() public {
        startHoax(o);
        nft.startMinting();
        nft.stopMinting();
        assertEq(address(nft.owner()), address(0));
        vm.expectRevert(bytes("Ownable: caller is not the owner"));
        nft.startMinting();
    }

    function testStopMintingOnlyIfStarted() public {
        startHoax(o);
        vm.expectRevert(bytes("minting not active"));
        nft.stopMinting();
        nft.startMinting();
        nft.stopMinting();
    }
    
    function testWithdrawWorks() public {
        hoax(o);
        nft.startMinting();
        hoax(t);
        nft.mint{value: mp * 20}(20);
        assertEq(address(nft).balance, mp * 20);
        hoax(o, 1 ether);
        nft.withdraw();
        assertEq(address(nft).balance, 0);
        assertEq(address(o).balance, 1 ether + mp * 20);
    }
    
    
    function testMintingRequiresEther() public {
        hoax(o);
        nft.startMinting();
        startHoax(t);
        vm.expectRevert(bytes("not enough ether sent"));
        nft.mint(1);
        vm.expectRevert(bytes("not enough ether sent"));
        nft.mint{value: .01636 ether}(1);
        nft.mint{value: mp}(1);
    }

    function testContractCannotReceiveEther() public {
        hoax(t);
        vm.expectRevert();
        payable(address(nft)).transfer(1 ether);
    }

    function testApprovalsWorkAfterStopping() public {
        startHoax(o);
        nft.startMinting();
        nft.ownerMint();
        assertEq(nft.isApprovedForAll(address(o), address(1)), false);
        vm.expectRevert(bytes("cannot allow approvals while still minting"));
        nft.setApprovalForAll(address(1), true);
        assertEq(nft.getApproved(1), address(0));
        vm.expectRevert(bytes("cannot allow approvals while still minting"));
        nft.approve(address(1), 1);
        nft.stopMinting();
        nft.setApprovalForAll(address(1), true);
        assertEq(nft.isApprovedForAll(address(o), address(1)), true);
        nft.approve(address(1), 1);
        assertEq(nft.getApproved(1), address(1));
    }

    function testTransferOwnerWorks() public {
        startHoax(o);
        nft.startMinting();
        nft.ownerMint();
        nft.transferOwnership(t);
        assertEq(nft.owner(), t);
        startHoax(t);
        nft.stopMinting();
        assertEq(nft.owner(), address(0));
    }
}

// Zarnold Edward Quigley
// Born in South End, New Quasar
// Major in business
// Interests include beer