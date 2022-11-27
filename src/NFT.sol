// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {ERC721} from "solmate/tokens/ERC721.sol";
import {Ownable} from "openzeppelin-contracts/access/Ownable.sol";
import {Base64} from "openzeppelin-contracts/utils/Base64.sol";
import {SVG} from "./SVG.sol";


contract NFT is ERC721, Ownable {
    SVG private svg;
    uint256 public currentTokenId;

    constructor(
        string memory _name,
        string memory _symbol
    ) ERC721(_name, _symbol) {}

    // https://github.com/GNSPS/solidity-bytes-utils/blob/master/contracts/BytesLib.sol 
    function toUint8(bytes memory _bytes, uint256 _start) internal pure returns (uint8) {
        require(_start + 1 >= _start, "toUint8_overflow");
        require(_bytes.length >= _start + 1 , "toUint8_outOfBounds");
        uint8 tempUint;

        assembly {
            tempUint := mload(add(add(_bytes, 0x1), _start))
        }

        return tempUint;
    }

    function generateSVGofTokenById(uint256 _tokenId) public virtual view returns (string memory) {
        return generateSVGFromHash(bytes32(_tokenId));
    }

    function generateSVGFromHash(bytes32 _hash) public virtual view returns (string memory) {
        bytes memory bhash = abi.encodePacked(_hash);
    }

    function mint() public payable {
        uint256 newItemId = ++currentTokenId;
        _safeMint(msg.sender, newItemId);
    }

    function totalSupply() public view returns (uint256 supply) {
        return currentTokenId;
    }

    function tokenURI(uint256 id) public view virtual override returns (string memory) {
        string memory image = Base64.encode(bytes(generateSVGofTokenById(id)));
        return string(
            abi.encodePacked(
                'data:application/json;base64,',
                Base64.encode(
                    bytes(
                        abi.encodePacked(
                            '{"name":"NFT token', id, '"',
                            '"description": "description"',
                            '"image": "data:image/svg+xml;base64,', image, '"}'
                        )
                    )
                )
            )
        );
    }

}