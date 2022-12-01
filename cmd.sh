#!/bin/bash

export CONTRACT=0x5FbDB2315678afecb367f032d93F642f64180aa3
source .env
forge create NFT --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY --constructor-args NFT NFT
# cast send --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY $CONTRACT "mint()"
# cast call $CONTRACT "tokenURI(uint256)" 1
# cast call $CONTRACT "tokenURI(uint256)" 0
