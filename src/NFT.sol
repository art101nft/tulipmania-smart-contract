// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from "solmate/tokens/ERC721.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {Base64} from "openzeppelin-contracts/utils/Base64.sol";
import {Strings} from "openzeppelin-contracts/utils/Strings.sol";


contract NFT is ERC721, Ownable {

    mapping(uint256 => string) public PaletteData;
    mapping(uint256 => mapping(uint256 => string)) public SymbolData;
    mapping(uint256 => string) public TulipData;
    
    uint256 public currentTokenId;
    uint256 public numPaletteColors;
    uint256 public numSymbols;
    uint256 public numTulipParts;
    uint256 public mintPrice = 0.025 ether;
    string private secret = "o23ueoaisjdqwjsdi2Itsd*&syuhdkajsIYT*&UIHHURE$RD";
    bool public lockChanges = false;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}


    /*
    * Update data stored within the contract
    */

    function updatePaletteData(string[] calldata colorCodes) external onlyOwner {
        require(lockChanges == false, "cannot change data");
        for (uint256 i; i < colorCodes.length; i++) {
            PaletteData[i] = colorCodes[i];
        }
        numPaletteColors = colorCodes.length;
    }

    function updateSymbolData(uint256 symbolIndex, string[] calldata symbolSVGData) external onlyOwner {
        require(lockChanges == false, "cannot change data");
        for (uint256 i; i < symbolSVGData.length; i++) {
            SymbolData[symbolIndex][i] = symbolSVGData[i];
        }
        numSymbols++;
    }

    function updateTulipData(string[] calldata tulipParts) external onlyOwner {
        require(lockChanges == false, "cannot change data");
        for (uint256 i; i < tulipParts.length; i++) {
            TulipData[i] = tulipParts[i];
        }
        numTulipParts = tulipParts.length;
    }


    /*
    * Rendering SVG contents
    */

    function getRandom(uint256 tokenId) public view returns (uint256 rand) {
        return uint(keccak256(abi.encodePacked(secret, tokenId)));
    }

    // get 7 random - no larger than number color palette (32)
    // get 4 random - no larger than number symbols (16)

    function renderStyles(
        uint256 gradient1,
        uint256 gradient2,
        uint256 bulb,
        uint256 stem,
        uint256 fur,
        uint256 lining,
        uint256 matte
    ) private view returns (string memory) {
        return string(
            abi.encodePacked(
                abi.encodePacked(
                    "<style>",
                    "#startGradient{stop-color:#", PaletteData[gradient1], "}",
                    "#stopGradient{stop-color:#", PaletteData[gradient2], "}",
                    ".blb{fill:#", PaletteData[bulb], "}",
                    ".stm{fill:#", PaletteData[stem], "}",
                    ".fr{fill:#", PaletteData[fur], "}"
                ),
                abi.encodePacked(
                    ".lnng{fill:#", PaletteData[lining], "}",
                    ".mtt{fill:#", PaletteData[matte], "}",
                    ".shdw{opacity:.30;fill:#231f20}",
                    ".flwr{fill:#f9f9f9}",
                    "</style>"
                )
            )
        );
    }

    function renderTulip() private view returns (string memory) {
        bytes memory output;
        for (uint256 i; i < numTulipParts; i++) {
            output = abi.encodePacked(output, TulipData[i]);
        }
        return string(output);
    }

    function renderSVG(uint256 tokenId) private view returns (string memory) {
        return string(
            abi.encodePacked(
                "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 800 1200' style='enable-background:new 0 0 800 1200' xml:space='preserve'>",
                renderStyles(0, 1, 2, 3, 4, 5, 6),
                renderTulip(),
                SymbolData[0][0],
                SymbolData[1][1],
                SymbolData[8][2],
                SymbolData[16][3],
                "</svg>"
            )
        );
    }


    /*
    * Minting
    */

    function mint() public payable {
        uint256 newItemId = ++currentTokenId;
        _safeMint(msg.sender, newItemId);
    }


    /*
    * Meta
    */

    function totalSupply() public view returns (uint256 supply) {
        return currentTokenId;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
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