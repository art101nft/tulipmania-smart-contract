// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "openzeppelin-contracts/access/Ownable.sol";
import "openzeppelin-contracts/token/ERC721/ERC721.sol";

import "./TulipsMetadata.sol";

contract CyberBrokers is ERC721, Ownable
{
	// Contracts
	TulipsMetadata public tulipsmetadata;

	// Constants
	uint256 constant public TOTAL_TOKENS = 20000;

	// Keeping track
	uint256 public MINT_PRICE = 0.025 ether;
	uint256 public totalMinted = 0;

	constructor() ERC721("NFT", "NFT"){}


	/**
	 * Metadata functionality
	 **/
	function setTulipsMetadataAddress(address _TulipsMetadataAddress) public onlyOwner {
		tulipsmetadata = TulipsMetadata(_TulipsMetadataAddress);
	}

	function tokenURI(uint256 tokenId) public view override returns (string memory) {
		require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");
		return tulipsmetadata.tokenURI(tokenId);
	}

	function render(uint256 _tokenId) external view returns (string memory) {
		require(_exists(_tokenId), "Non-existent token to render.");
		return tulipsmetadata.render(_tokenId);
	}


	/**
	 * Wrapper for Enumerable functions: totalSupply & getTokens
	 **/
	function totalSupply() public view returns (uint256) {
		return totalMinted;
	}

	// Do not use this on-chain, it's O(N)
	// This is why we use a non-standard name instead of tokenOfOwnerByIndex
	function getTokens(address addr) public view returns (uint256[] memory) {
		// Prepare array of tokens
		uint256 numTokensOwned = balanceOf(addr);
		uint[] memory tokens = new uint[](numTokensOwned);

		uint256 currentTokensIdx;
		for (uint256 idx; idx < TOTAL_TOKENS; idx++) {
			if (_exists(idx) && ownerOf(idx) == addr) {
				tokens[currentTokensIdx++] = idx;

				if (currentTokensIdx == numTokensOwned) {
					break;
				}
			}
		}

		return tokens;
	}


	/**
	 * Minting functionality
	 **/

	function buy(address to, uint256 tokenId) private {
		require(totalMinted < TOTAL_TOKENS, "Max CyberBrokers minted");
		_mint(to, tokenId);
		totalMinted++;
	}


	/**
	 * Withdraw functions
	 **/
	function withdraw() public onlyOwner {
		uint256 balance = address(this).balance;
		(bool success,) = msg.sender.call{value: balance}('');
		require(success, 'Fail Transfer');
	}


	/**
	 * On-Chain Royalties & Interface
	 **/
	function supportsInterface(bytes4 interfaceId)
		public
		view
		override
		returns (bool)
	{
		return
			interfaceId == this.royaltyInfo.selector ||
			super.supportsInterface(interfaceId);
	}

	function royaltyInfo(uint256, uint256 amount)
		public
		view
		returns (address, uint256)
	{
		// 5% royalties
		return (owner(), (amount * 500) / 10000);
	}

}