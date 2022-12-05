#!/bin/bash

export $(cat .env)
forge create NFT --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY --constructor-args "top@secret"
#cast send --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY $LOCAL_CONTRACT "mint()"
