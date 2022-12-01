#!/usr/bin/env python3

import json
from web3 import Web3
from os import getenv, path, walk
from glob import glob

# forge create NFT --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY --constructor-args NFT NFT
# cast send --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY $CONTRACT "updateTulipData(string[])"

WEB3_PROVIDER_URI = f'http://127.0.0.1:8545'
w3 = Web3(Web3.HTTPProvider(WEB3_PROVIDER_URI))

def get_eth_contract(_ca, _rp):
    compiled_contract_path = path.abspath(_rp)

    with open(compiled_contract_path) as file:
        contract_json = json.load(file)
        contract_abi = contract_json['abi']

    return w3.eth.contract(address=w3.toChecksumAddress(_ca), abi=contract_abi)


def get_palette_data():
    codes = []
    with open('./data/Color_Palette.txt', 'r') as f:
        _f = f.readlines()
        for line in _f:
            code = line.split('#')[1].strip()
            codes.append(code)
    return codes

def get_symbol_data():
    idx = 0
    symbols = {}
    for subdir in sorted(glob('./data/Symbols/*')):
        symbols[idx] = []
        for svg in sorted(glob(path.join(subdir, '*.svg'))):
            with open(svg, 'r') as f:
                _f = f.read()
                symbols[idx].append(_f)
        idx += 1
    return symbols

def get_tulip_data():
    tulips = []
    for svg in sorted(glob('./data/Tulip/*.svg')):
        with open(svg, 'r') as f:
            _f = f.read()
            tulips.append(_f)
    return tulips


if __name__ == '__main__':
    if not getenv('CONTRACT'):
        print('CONTRACT not specified')
        exit()
    if not getenv('LOCAL_KEY'):
        print('LOCAL_KEY not specified')
        exit()
    
    w3.eth.defaultAccount = w3.eth.account.from_key(getenv('LOCAL_KEY')).address
    palette_data = get_palette_data()
    symbol_data = get_symbol_data()
    tulip_data = get_tulip_data()
    contract = get_eth_contract(getenv('CONTRACT'), './out/NFT.sol/NFT.json')

    total_gas = []
    r = contract.functions.updatePaletteData(palette_data).estimate_gas()
    print(f'{r} gas to publish palette data')
    total_gas.append(r)
    for i in symbol_data:
        r = contract.functions.updateSymbolData(i, symbol_data[i]).estimate_gas()
        print(f'{r} gas to publish symbol data ({i})')
        total_gas.append(r)
    r = contract.functions.updateTulipData(tulip_data).estimate_gas()
    print(f'{r} gas to publish tulip data')
    total_gas.append(r)

    print(f'\nTotal gas required to publish {len(palette_data)} color palettes, {len(symbol_data)} symbols, and {len(tulip_data)} tulip pieces:\n{sum(total_gas)}')
