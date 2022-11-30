// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from "solmate/tokens/ERC721.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {Base64} from "openzeppelin-contracts/utils/Base64.sol";
import {Strings} from "openzeppelin-contracts/utils/Strings.sol";


contract NFT is ERC721, Ownable {
    uint256 public currentTokenId;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}

    function openSVG() private pure returns (string memory) {
        return string("<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 800 1200' style='enable-background:new 0 0 800 1200' xml:space='preserve'>");
    }

    function closeSVG() private pure returns (string memory) {
        return string("</svg>");
    }

    function getTokenName(uint256 tokenId) private pure returns (string memory) {
        return string(
            abi.encodePacked(
                "Tulips #",
                tokenId
            )
        );
    }

    function render(uint256 tokenId) private pure returns (string memory) {
        return string(
            abi.encodePacked(
                openSVG(),
                logoBTC(0),
                closeSVG()
            )
        );
    }

    // Quadrant 0, top-left, 1, top-right, 2, bottom-right, 3, bottom-left

    function logoBTC(uint256 quadrant) private pure returns (string memory) {
        if (quadrant == 0) {
            return string(
                abi.encodePacked(
                    "<path d='M235.1 191.6c-8.5 34.3-43.3 55.2-77.6 46.6-34.3-8.5-55.1-43.3-46.6-77.6s43.3-55.2 77.6-46.6c34.2 8.6 55.1 43.3 46.6 77.6z' style='fill:#f9f9f9'/>",
                    "<path d='M201.2 167c1.3-8.5-5.2-13.1-14.1-16.1l2.9-11.5-7-1.8-2.8 11.2c-1.8-.5-3.7-.9-5.6-1.3l2.8-11.3-7-1.8-2.9 11.5c-1.5-.3-3-.7-4.5-1.1l-9.7-2.4-1.9 7.5s5.2 1.2 5.1 1.3c2.8.7 3.4 2.6 3.3 4.1l-3.3 13.1c.2 0 .5.1.7.2-.2-.1-.5-.1-.7-.2l-4.6 18.4c-.3.9-1.2 2.2-3.2 1.7.1.1-5.1-1.3-5.1-1.3l-3.5 8 9.1 2.3c1.7.4 3.4.9 5 1.3l-2.9 11.7 7 1.8 2.9-11.5c1.9.5 3.8 1 5.6 1.5l-2.9 11.5 7 1.8 2.9-11.6c12 2.3 21 1.4 24.8-9.5 3.1-8.7-.2-13.8-6.5-17 4.7-1.2 8.2-4.3 9.1-10.5zm-16.1 22.5c-2.2 8.7-16.9 4-21.6 2.8l3.9-15.5c4.7 1.3 20 3.6 17.7 12.7zm2.2-22.6c-2 7.9-14.2 3.9-18.2 2.9l3.5-14c4 1 16.8 2.8 14.7 11.1z' style='fill:#f7931a'/>"
                )
            );
        } else if (quadrant == 1) {
            return string(
                abi.encodePacked(
                    "<path d='M686.5 191.6c-8.5 34.3-43.3 55.2-77.6 46.6-34.3-8.5-55.1-43.3-46.6-77.6s43.3-55.2 77.6-46.6c34.3 8.6 55.2 43.3 46.6 77.6z' style='fill:#f9f9f9'/>",
                    "<path d='M652.6 167c1.3-8.5-5.2-13.1-14.1-16.1l2.9-11.5-7-1.8-2.8 11.2c-1.8-.5-3.7-.9-5.6-1.3l2.8-11.3-7-1.8-2.9 11.5c-1.5-.3-3-.7-4.5-1.1l-9.7-2.4-1.9 7.5s5.2 1.2 5.1 1.3c2.8.7 3.4 2.6 3.3 4.1l-3.3 13.1c.2 0 .5.1.7.2-.2-.1-.5-.1-.7-.2l-4.6 18.4c-.3.9-1.2 2.2-3.2 1.7.1.1-5.1-1.3-5.1-1.3l-3.5 8 9.1 2.3c1.7.4 3.4.9 5 1.3l-2.9 11.7 7 1.8 2.9-11.5c1.9.5 3.8 1 5.6 1.5l-2.9 11.5 7 1.8 2.9-11.6c12 2.3 21 1.4 24.8-9.5 3.1-8.7-.2-13.8-6.5-17 4.8-1.2 8.2-4.3 9.1-10.5zm-16 22.5c-2.2 8.7-16.9 4-21.6 2.8l3.9-15.5c4.7 1.3 20 3.6 17.7 12.7zm2.2-22.6c-2 7.9-14.2 3.9-18.2 2.9l3.5-14c4 1 16.7 2.8 14.7 11.1z' style='fill:#f7931a'/>"
                )
            );
        } else if (quadrant == 2) {
            return string(
                abi.encodePacked(
                    "<path d='M686.5 1040c-8.5 34.3-43.3 55.2-77.6 46.6-34.3-8.5-55.1-43.3-46.6-77.6s43.3-55.2 77.6-46.6c34.3 8.6 55.2 43.3 46.6 77.6z' style='fill:#f9f9f9'/>",
                    "<path d='M652.6 1015.4c1.3-8.5-5.2-13.1-14.1-16.1l2.9-11.5-7-1.8-2.8 11.2c-1.8-.5-3.7-.9-5.6-1.3l2.8-11.3-7-1.8-2.9 11.5c-1.5-.3-3-.7-4.5-1.1l-9.7-2.4-1.9 7.5s5.2 1.2 5.1 1.3c2.8.7 3.4 2.6 3.3 4.1l-3.3 13.1c.2 0 .5.1.7.2-.2-.1-.5-.1-.7-.2l-4.6 18.4c-.3.9-1.2 2.2-3.2 1.7.1.1-5.1-1.3-5.1-1.3l-3.5 8 9.1 2.3c1.7.4 3.4.9 5 1.3l-2.9 11.7 7 1.8 2.9-11.5c1.9.5 3.8 1 5.6 1.5l-2.9 11.5 7 1.8 2.9-11.6c12 2.3 21 1.4 24.8-9.5 3.1-8.7-.2-13.8-6.5-17 4.8-1.3 8.2-4.3 9.1-10.5zm-16 22.5c-2.2 8.7-16.9 4-21.6 2.8l3.9-15.5c4.7 1.2 20 3.6 17.7 12.7zm2.2-22.6c-2 7.9-14.2 3.9-18.2 2.9l3.5-14c4 .9 16.7 2.8 14.7 11.1z' style='fill:#f7931a'/>"
                )
            );
        } else if (quadrant == 3) {
            return string(
                abi.encodePacked(
                    "<path d='M235.1 1040c-8.5 34.3-43.3 55.2-77.6 46.6-34.3-8.5-55.1-43.3-46.6-77.6s43.3-55.2 77.6-46.6c34.2 8.6 55.1 43.3 46.6 77.6z' style='fill:#f9f9f9'/>",
                    "<path d='M201.2 1015.4c1.3-8.5-5.2-13.1-14.1-16.1l2.9-11.5-7-1.8-2.8 11.2c-1.8-.5-3.7-.9-5.6-1.3l2.8-11.3-7-1.8-2.9 11.5c-1.5-.3-3-.7-4.5-1.1l-9.7-2.4-1.9 7.5s5.2 1.2 5.1 1.3c2.8.7 3.4 2.6 3.3 4.1l-3.3 13.1c.2 0 .5.1.7.2-.2-.1-.5-.1-.7-.2l-4.6 18.4c-.3.9-1.2 2.2-3.2 1.7.1.1-5.1-1.3-5.1-1.3l-3.5 8 9.1 2.3c1.7.4 3.4.9 5 1.3l-2.9 11.7 7 1.8 2.9-11.5c1.9.5 3.8 1 5.6 1.5l-2.9 11.5 7 1.8 2.9-11.6c12 2.3 21 1.4 24.8-9.5 3.1-8.7-.2-13.8-6.5-17 4.7-1.3 8.2-4.3 9.1-10.5zm-16.1 22.5c-2.2 8.7-16.9 4-21.6 2.8l3.9-15.5c4.7 1.2 20 3.6 17.7 12.7zm2.2-22.6c-2 7.9-14.2 3.9-18.2 2.9l3.5-14c4 .9 16.8 2.8 14.7 11.1z' style='fill:#f7931a'/>"
                )
            );
        } else {
            return string("");
        }
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
                        Base64.encode(bytes(render(tokenId))), 
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