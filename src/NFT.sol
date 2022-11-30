// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from "solmate/tokens/ERC721.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {Base64} from "openzeppelin-contracts/utils/Base64.sol";
import {Strings} from "openzeppelin-contracts/utils/Strings.sol";


contract NFT is ERC721, Ownable {

    mapping(uint256 => string) internal PaletteData;
    mapping(uint256 => mapping(uint256 => string)) internal CornerData;
    mapping(uint256 => string) internal TulipPieceData;

    // -------------- corner data
    // 0 - APE
    // 1 - BTC
    // 2 - DAI
    // 3 - DOGE
    // 4 - ETH
    // ...
    //   - 0 - top left
    //   - 1 - top right
    //   - 2 - bottom left
    //   - 3 - bottom right

    // -------------- tulip data
    // 0 - background
    // 1 - bulb
    // 2 - center stem
    // 3 - fur
    // 4 - leaf back
    // 5 - leaf lining
    // 6 - canvas background
    // 7 - tulip shadow
    // 8 - tulip stem
    
    uint256 public currentTokenId;
    uint256 public mintPrice = 0.025 ether;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}

    function renderSVG(uint256 tokenId) private pure returns (string memory) {
        return string(
            abi.encodePacked(
                "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 800 1200' style='enable-background:new 0 0 800 1200' xml:space='preserve'>",
                "</svg>"
            )
        );
    }

    function mint() public payable {
        uint256 newItemId = ++currentTokenId;
        _safeMint(msg.sender, newItemId);
    }

    function totalSupply() public view returns (uint256 supply) {
        return currentTokenId;
    }

    function tokenURI(uint256 tokenId) public pure override returns (string memory) {
        require(tokenId <= 10000, "Invalid tokenId");
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Tulip #', 
                        Strings.toString(tokenId), 
                        '", "description": "this is a test.", "image_data": "data:image/svg+xml;base64,', 
                        Base64.encode(bytes(renderSVG(tokenId))), 
                        '"}'
                    )
                )
            )
        );
        return string(
            abi.encodePacked(
                'data:application/json;base64,', 
                json
            )
        );
    }

}