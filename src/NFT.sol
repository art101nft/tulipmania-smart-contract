// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721A} from "erc721a/ERC721A.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {Base64} from "openzeppelin-contracts/utils/Base64.sol";
import {Strings} from "openzeppelin-contracts/utils/Strings.sol";


contract NFT is ERC721A, Ownable {

    mapping(uint256 => string) public PaletteData;
    mapping(uint256 => mapping(uint256 => string)) public SymbolData;
    mapping(uint256 => string) public SymbolNames;
    mapping(uint256 => string) public TulipData;

    bool public ownerMinted;
    bool public mintingAllowed;
    bool public mintingHalted;
    address public deployer;
    uint256 public ownerMintAmount = 250;
    uint256 public numPaletteColors;
    uint256 public numSymbols;
    uint256 public numTulipParts;
    uint256 public mintPrice = 0.01637 ether;
    string public secret;

    constructor(string memory _secret) ERC721A("Tulip Mania", "TULIP") {
        secret = _secret;
        deployer = msg.sender;
    }

    /*
    * Manage
    */

    function startMinting() external onlyOwner {
        mintingAllowed = true;
    }

    function stopMinting() external onlyOwner {
        require(mintingAllowed == true, "minting not active");
        mintingAllowed = false;
        mintingHalted = true;
        withdraw();
        renounceOwnership();
    }

    function ownerMint() external onlyOwner {
        require(ownerMinted == false, "owner already minted");
        _safeMint(msg.sender, ownerMintAmount);
        ownerMinted = true;
    }

    function withdraw() public onlyOwner {
        payable(msg.sender).transfer(address(this).balance);
    }


    /*
    * Minting
    */

    function mint(uint256 amount) external payable {
        require(mintingAllowed == true, "minting not allowed");
        require(mintingHalted == false, "minting not allowed");
        require(msg.value == mintPrice * amount, "not enough ether sent");
        _safeMint(msg.sender, amount);
    }


    /*
    * Storing SVG data
    */

    function updatePaletteData(string[] calldata colorCodes) external onlyOwner {
        for (uint256 i; i < colorCodes.length; i++) {
            PaletteData[i] = colorCodes[i];
        }
        numPaletteColors = colorCodes.length;
    }

    function updateSymbolData(uint256 symbolIndex, string[] calldata symbolSVGData) external onlyOwner {
        for (uint256 i; i < symbolSVGData.length; i++) {
            SymbolData[symbolIndex][i] = symbolSVGData[i];
        }
    }

    function updateSymbolNames(string[] calldata symbolNames) external onlyOwner {
        for (uint256 i; i < symbolNames.length; i++) {
            SymbolNames[i] = symbolNames[i];
        }
        numSymbols = symbolNames.length;
    }

    function updateTulipData(string[] calldata tulipParts) external onlyOwner {
        for (uint256 i; i < tulipParts.length; i++) {
            TulipData[i] = tulipParts[i];
        }
        numTulipParts = tulipParts.length;
    }


    /*
    * Rendering SVG data
    */

    function getRandomUint(string memory data, uint256 tokenId) private view returns (uint256 rand) {
        return uint256(keccak256(abi.encodePacked(secret, data, tokenId)));
    }

    function getRandomColors(uint256 tokenId, string memory salt) public view returns (uint256[4] memory rands) {
        string[4] memory data = [
            string(abi.encodePacked(salt, "1")), 
            string(abi.encodePacked(salt, "2")), 
            string(abi.encodePacked(salt, "3")), 
            string(abi.encodePacked(salt, "4"))
        ];
        uint256[4] memory _rands;
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

    function renderStyle(
        string memory className, 
        string memory animationType,
        uint256 duration,
        uint256[4] memory colorIds
    ) private view returns (string memory) {
        return string(
            abi.encodePacked(
                abi.encodePacked(
                    ".", className, 
                    "{animation: ", className, 
                    " ", Strings.toString(duration), 
                    "s ease alternate infinite } ",
                    "@keyframes ", className
                ),
                abi.encodePacked(
                    " { 0% { ", animationType, ": #", PaletteData[colorIds[0]], 
                    "} 33% { ", animationType, ": #", PaletteData[colorIds[1]], 
                    " } 66% { ", animationType, ": #", PaletteData[colorIds[2]], 
                    "} 100% { ", animationType, ": #", PaletteData[colorIds[3]], 
                    "} } "
                )
            )
        );
    }

    function renderStyles(uint256 tokenId) private view returns (string memory) {
        return string(
            abi.encodePacked(
                "<style>",
                abi.encodePacked(
                    ".wht {fill: white; animation: btw 15s ease alternate infinite} ",
                    ".blck {fill: black; animation: wtb 15s ease alternate infinite} ",
                    "@keyframes btw { 0% { fill: #231f20 } 25% { fill: #f9f9f9 } 50% { fill: #231f20} 75% { fill: #f9f9f9 } 100% { fill: #231f20} } ",
                    "@keyframes wtb { 0% { fill: #f9f9f9 } 25% { fill: #231f20 } 50% { fill: #f9f9f9} 75% { fill: #231f20 } 100% { fill: #f9f9f9} } ",
                    "#startGradient {animation: startGradient 15s ease alternate infinite} ",
                    "@keyframes startGradient { 0% { transform: rotate(0) } 50%{ transform: rotate(20deg) } 100%{ transform: rotate(40deg) } } ",
                    "#stopGradient {animation: stopGradient 15s ease alternate infinite} ",
                    "@keyframes stopGradient { 0% { transform: rotate(0) } 50%{ transform: rotate(20deg) } 100%{ transform: rotate(40deg) } } "
                ),
                abi.encodePacked(
                    renderStyle("stem", "fill", 10, getRandomColors(tokenId, "stem")),
                    renderStyle("leaf-lining", "fill", 12, getRandomColors(tokenId, "leaf-lining")),
                    renderStyle("matte", "fill", 20, getRandomColors(tokenId, "matte")),
                    renderStyle("startGradientStop1", "stop-color", 5, getRandomColors(tokenId, "startGradientStop1")),
                    renderStyle("startGradientStop2", "stop-color", 15, getRandomColors(tokenId, "startGradientStop2")),
                    renderStyle("stopGradientStop1", "stop-color", 25, getRandomColors(tokenId, "stopGradientStop1")),
                    renderStyle("stopGradientStop2", "stop-color", 35, getRandomColors(tokenId, "stopGradientStop2"))
                ),
                "</style>"      
            )
        );
    }

    function renderMetadata(uint256 tokenId) private view returns (string memory) {
        uint256[4] memory stemColors = getRandomColors(tokenId, "stem");
        uint256[4] memory liningColors = getRandomColors(tokenId, "leaf-lining");
        uint256[4] memory matteColors = getRandomColors(tokenId, "matte");
        uint256[4] memory startGradient1Colors = getRandomColors(tokenId, "startGradientStop1");
        uint256[4] memory startGradient2Colors = getRandomColors(tokenId, "startGradientStop2");
        uint256[4] memory stopGradient1Colors = getRandomColors(tokenId, "stopGradientStop1");
        uint256[4] memory stopGradient2Colors = getRandomColors(tokenId, "stopGradientStop2");
        uint256[4] memory symbolIds = getRandomSymbols(tokenId);
        return string(
            abi.encodePacked(
                '[{"trait_type": "StemColors", "value": "',
                abi.encodePacked(
                    '#', PaletteData[stemColors[0]],
                    ',#', PaletteData[stemColors[1]],
                    ',#', PaletteData[stemColors[2]],
                    ',#', PaletteData[stemColors[3]]
                ),
                '"}, {"trait_type": "LiningColors", "value": "',
                abi.encodePacked(
                    '#', PaletteData[liningColors[0]],
                    ',#', PaletteData[liningColors[1]],
                    ',#', PaletteData[liningColors[2]],
                    ',#', PaletteData[liningColors[3]]
                ),
                '"}, {"trait_type": "matteColors", "value": "',
                abi.encodePacked(
                    '#', PaletteData[matteColors[0]],
                    ',#', PaletteData[matteColors[1]],
                    ',#', PaletteData[matteColors[2]],
                    ',#', PaletteData[matteColors[3]]
                ),
                '"}, {"trait_type": "startGradientColors", "value": "',
                abi.encodePacked(
                    '#', PaletteData[startGradient1Colors[0]],
                    ',#', PaletteData[startGradient1Colors[1]],
                    ',#', PaletteData[startGradient1Colors[2]],
                    ',#', PaletteData[startGradient1Colors[3]],
                    ',#', PaletteData[startGradient2Colors[0]],
                    ',#', PaletteData[startGradient2Colors[1]],
                    ',#', PaletteData[startGradient2Colors[2]],
                    ',#', PaletteData[startGradient2Colors[3]]
                ),
                '"}, {"trait_type": "stopGradientColors", "value": "',
                abi.encodePacked(
                    '#', PaletteData[stopGradient1Colors[0]],
                    ',#', PaletteData[stopGradient1Colors[1]],
                    ',#', PaletteData[stopGradient1Colors[2]],
                    ',#', PaletteData[stopGradient1Colors[3]],
                    ',#', PaletteData[stopGradient2Colors[0]],
                    ',#', PaletteData[stopGradient2Colors[1]],
                    ',#', PaletteData[stopGradient2Colors[2]],
                    ',#', PaletteData[stopGradient2Colors[3]]
                ),
                abi.encodePacked(
                    '"}, {"trait_type": "BottomLeft", "value": "', SymbolNames[symbolIds[0]],
                    '"}, {"trait_type": "BottomRight", "value": "', SymbolNames[symbolIds[1]],
                    '"}, {"trait_type": "TopLeft", "value": "', SymbolNames[symbolIds[2]],
                    '"}, {"trait_type": "TopRight", "value": "', SymbolNames[symbolIds[3]]
                ),
                '"}]'
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
        uint256[4] memory symbols = getRandomSymbols(tokenId);
        return string(
            abi.encodePacked(
                "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 800 1200' style='enable-background:new 0 0 800 1200' xml:space='preserve'>",
                renderStyles(tokenId),
                renderTulip(),
                renderSymbols(symbols),
                "</svg>"
            )
        );
    }


    /*
    * Meta
    */

    function approve(address to, uint256 tokenId) public payable virtual override {
        require(mintingAllowed == false, "cannot allow approvals while still minting");
        super.approve(to, tokenId);
    }

    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(mintingAllowed == false, "cannot allow approvals while still minting");
        super.setApprovalForAll(operator, approved);
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory json = Base64.encode(
            bytes(
                string(
                    abi.encodePacked(
                        '{"name": "Tulip #', Strings.toString(tokenId), '"',
                        ', "description": "Normies are meme-ing tulips again and you\'ve spent the last 2 years buyin\' \'em. Why not mint one? Tulip Mania! is generative, animated, and 100% on-chain vector art. No allowlist, no promises, and no royalties. Tulip Mania! is a celebration of irrational exuberance. The content is cc0 and low on rarity."',
                        ', "attributes": ', renderMetadata(tokenId),
                        ', "image_data": "data:image/svg+xml;base64,',
                        Base64.encode(bytes(renderSVG(tokenId))), '"',
                        '}'
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