# tulips



## dev notes 


```
export CONTRACT=0x5FbDB2315678afecb367f032d93F642f64180aa3
source .env
forge create NFT --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY --constructor-args NFT NFT
# cast send --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY $CONTRACT "mint()"
# cast call $CONTRACT "tokenURI(uint256)" 1
# cast call $CONTRACT "tokenURI(uint256)" 0

forge create NFT --rpc-url=$TESTNET_RPC --private-key=$TESTNET_KEY --constructor-args "redrum"
CHECK=1 NET=testnet .venv/bin/python3 manage.py
PUSH=1 NET=testnet .venv/bin/python3 manage.py
CHECK=1 NET=testnet .venv/bin/python3 manage.py
cast send --rpc-url=$TESTNET_RPC --private-key=$TESTNET_KEY $TESTNET_CONTRACT "totalSupply()"
for i in 1..201; do curl https://testnets-api.opensea.io/api/v1/asset/$TESTNET_CONTRACT/$i/?force_update=true; done
```