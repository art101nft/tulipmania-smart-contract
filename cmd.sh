#!/bin/bash

source .env
forge create NFT --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY --constructor-args NFT NFT
cast send --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY 0x5FbDB2315678afecb367f032d93F642f64180aa3 "mint()"
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "tokenURI(uint256)" 1
cast call 0x5FbDB2315678afecb367f032d93F642f64180aa3 "tokenURI(uint256)" 0

