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

    uint256 constant public MAX_SUPPLY = 5555;
    
    bool public lockChanges;
    uint256 public currentTokenId;
    uint256 public numPaletteColors;
    uint256 public numSymbols;
    uint256 public numTulipParts;
    uint256 public mintPrice = 0.1 ether;
    string private secret;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}


    /*
    * Minting
    */

    function mint() public payable {
        // variable amount to mint
        // require funds
        uint256 newItemId = ++currentTokenId;
        _safeMint(msg.sender, newItemId);
    }


    /*
    * Update data stored within the contract
    */

    function updateMintPrice(uint256 amount) external onlyOwner {
        mintPrice = amount;
    }

    function updateSecret(string memory val) external onlyOwner {
        require(lockChanges == false, "cannot change data");
        secret = val;
    }

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
        if(symbolIndex + 1 > numSymbols) {
            numSymbols = symbolIndex + 1;
        }

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

    function getRandomUint(string memory data, uint256 tokenId) private view returns (uint256 rand) {
        return uint256(keccak256(abi.encodePacked(secret, data, tokenId)));
    }

    function getRandomColors(uint256 tokenId) public view returns (uint256[6] memory rands) {
        string[6] memory data = ["startGradient", "stopGradient", "bulb", "stem", "lining", "matte"];
        uint256[6] memory _rands;
        for(uint256 i; i < data.length; i++) {
            uint256 rand = getRandomUint(data[i], tokenId);
            _rands[i] = rand % numPaletteColors;
        }
        return _rands;
    }

    function getRandomSymbols(uint256 tokenId) public view returns (uint256[4] memory rands) {
        string[4] memory data = ["bottomleft", "bottomright", "topleft", "topright"];
        uint256[4] memory _rands;
        for(uint256 i; i < data.length; i++) {
            uint256 rand = getRandomUint(data[i], tokenId);
            _rands[i] = rand % numSymbols;
        }
        return _rands;
    }

    function renderStyles(uint256[6] memory colorIds) private view returns (string memory) {
        return string(
            abi.encodePacked(
                abi.encodePacked(
                    "<style>",
                    "#startGradient{stop-color:#", PaletteData[colorIds[0]], "}",
                    "#stopGradient{stop-color:#", PaletteData[colorIds[1]], "}",
                    ".blb{fill:#", PaletteData[colorIds[2]], "}",
                    ".stm{fill:#", PaletteData[colorIds[3]], "}"
                ),
                abi.encodePacked(
                    ".lnng{fill:#", PaletteData[colorIds[4]], "}",
                    ".mtt{fill:#", PaletteData[colorIds[5]], "}",
                    ".shdw{opacity:.30;fill:#231f20}",
                    ".flwr{fill:#f9f9f9}",
                    ".fr{fill:#5f4a48}",
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

    function renderSymbols(uint256[4] memory symbolIds) private view returns (string memory) {
        return string(
            abi.encodePacked(
                SymbolData[symbolIds[0]][0],
                SymbolData[symbolIds[1]][1],
                SymbolData[symbolIds[2]][2],
                SymbolData[symbolIds[3]][3]
            )
        );
    }

    function renderSVG(uint256 tokenId) private view returns (string memory) {
        uint256[6] memory styleColors = getRandomColors(tokenId);
        uint256[4] memory symbols = getRandomSymbols(tokenId);
        return string(
            abi.encodePacked(
                "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 800 1200' style='enable-background:new 0 0 800 1200' xml:space='preserve'>",
                renderStyles(styleColors),
                renderTulip(),
                renderSymbols(symbols),
                "</svg>"
            )
        );
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