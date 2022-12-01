#!/usr/bin/env python3

import json
from web3 import Web3
from os import getenv, path
from glob import glob

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

def sendit(w3, t, nonce):
    t['from'] = w3.eth.defaultAccount
    t['nonce'] = nonce
    nonce += 1
    s = w3.eth.account.sign_transaction(t, private_key=getenv('TESTNET_KEY'))
    w3.eth.send_raw_transaction(s.rawTransaction)
    return s.hash

if __name__ == '__main__':
    if not getenv('TESTNET_CONTRACT') or not getenv('TESTNET_KEY') or not getenv('TESTNET_RPC'):
        print('invalid env vars set')
        exit()
    
    WEB3_PROVIDER_URI = getenv('TESTNET_RPC')
    w3 = Web3(Web3.HTTPProvider(WEB3_PROVIDER_URI))
    w3.eth.defaultAccount = w3.eth.account.from_key(getenv('TESTNET_KEY')).address
    palette_data = get_palette_data()
    symbol_data = get_symbol_data()
    tulip_data = get_tulip_data()
    contract = get_eth_contract(getenv('TESTNET_CONTRACT'), './out/NFT.sol/NFT.json')

    # total_gas = []
    # r = contract.functions.updatePaletteData(palette_data).estimate_gas()
    # total_gas.append(r)
    # for i in symbol_data:
    #     r = contract.functions.updateSymbolData(i, symbol_data[i]).estimate_gas()
    #     total_gas.append(r)
    # r = contract.functions.updateTulipData(tulip_data).estimate_gas()
    # total_gas.append(r)

    nonce = w3.eth.get_transaction_count(w3.eth.defaultAccount)

    r = sendit(w3, contract.functions.updatePaletteData(palette_data).build_transaction(), nonce)
    print(f'sent tx {r} with nonce {nonce}')
    nonce += 1
    for i in symbol_data:
        r = sendit(w3, contract.functions.updateSymbolData(i, symbol_data[i]).build_transaction(), nonce)
        print(f'sent tx {r} with nonce {nonce}')
        nonce += 1
    r = sendit(w3, contract.functions.updateTulipData(tulip_data).build_transaction(), nonce)
    print(f'sent tx {r} with nonce {nonce}')
    nonce += 1
