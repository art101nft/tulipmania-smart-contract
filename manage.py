#!/usr/bin/env python3

from web3 import Web3
from bs4 import BeautifulSoup


import json

from base64 import b64decode
from os import getenv, path
from glob import glob


def get_eth_contract(_ca, _rp):
    compiled_contract_path = path.abspath(_rp)
    with open(compiled_contract_path) as file:
        contract_json = json.load(file)
        contract_abi = contract_json['abi']
    return w3.eth.contract(address=w3.toChecksumAddress(_ca), abi=contract_abi)

def get_svg_contents(svg: str) -> str:
    soup = BeautifulSoup(svg, 'xml')
    return "".join([str(i).strip() for i in soup.svg.children])

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
    names = []
    for subdir in sorted(glob('./data/Symbols/*')):
        names.append(path.basename(subdir))
        symbols[idx] = []
        for svg in sorted(glob(path.join(subdir, '*.svg'))):
            with open(svg, 'r') as f:
                _f = get_svg_contents(f.read())
                symbols[idx].append(_f)
        idx += 1
    return (symbols, names)

def get_tulip_data():
    tulips = []
    for svg in sorted(glob('./data/Tulip/*.svg')):
        with open(svg, 'r') as f:
            _f = get_svg_contents(f.read())
            tulips.append(_f)
    return tulips

def sendit(w3, t, nonce):
    t['from'] = w3.eth.defaultAccount
    t['nonce'] = nonce
    nonce += 1
    s = w3.eth.account.sign_transaction(t, private_key=getenv(f'{net}_KEY'))
    return w3.eth.send_raw_transaction(s.rawTransaction)

if __name__ == '__main__':
    net = getenv('NET').upper()
    if not getenv(f'{net}_CONTRACT') or not getenv(f'{net}_KEY') or not getenv(f'{net}_RPC'):
        print('invalid env vars set')
        exit()
    
    # get the data from local SVG
    palette_data = get_palette_data()
    print(f'[+] Found {len(palette_data)} colors for the palette')
    symbol_data = get_symbol_data()[0]
    symbol_names = get_symbol_data()[1]
    print(f'[+] Found {len(symbol_data)} symbols ({len(symbol_data) * 4} options possible with top, bottom, left, right)')
    tulip_data = get_tulip_data()
    print(f'[+] Found {len(tulip_data)} tulip pieces')

    # web3 setup
    WEB3_PROVIDER_URI = getenv(f'{net}_RPC')
    w3 = Web3(Web3.HTTPProvider(WEB3_PROVIDER_URI))
    w3.eth.defaultAccount = w3.eth.account.from_key(getenv(f'{net}_KEY')).address
    contract = get_eth_contract(getenv(f'{net}_CONTRACT'), './out/NFT.sol/NFT.json')

    # Calculate gas
    if getenv('CHECK'):
        gwei = 15
        print('[+] Checking gas consumption requirements')
        total_gas = []
        print(f'2000000 gas to deploy contract')
        total_gas.append(2000000)
        r = contract.functions.updatePaletteData(palette_data).estimate_gas()
        print(f'{r} gas to push palette data')
        total_gas.append(r)
        for i in symbol_data:
            r = contract.functions.updateSymbolData(i, symbol_data[i]).estimate_gas()
            print(f'{r} gas to push symbol {i} data ({len(symbol_data[i])} pieces)')
            total_gas.append(r)
        r = contract.functions.updateSymbolNames(symbol_names).estimate_gas()
        print(f'{r} gas to push symbol names')
        total_gas.append(r)
        r = contract.functions.updateTulipData(tulip_data).estimate_gas()
        print(f'{r} gas to push tulip data')
        total_gas.append(r)
        print(f'You will need {sum(total_gas)} gas to upload all the SVG data. That is approximately {w3.fromWei((sum(total_gas) * gwei), "gwei")} ETH at {gwei} gwei')

    # Push SVG data into the contract
    if getenv('PUSH'):
        nonce = w3.eth.get_transaction_count(w3.eth.defaultAccount)
        r = sendit(w3, contract.functions.updatePaletteData(palette_data).build_transaction(), nonce)
        print(f'sent tx {r.hex()} with nonce {nonce}')
        nonce += 1
        r = sendit(w3, contract.functions.updateSymbolNames(symbol_names).build_transaction(), nonce)
        print(f'sent tx {r.hex()} with nonce {nonce}')
        nonce += 1
        for i in symbol_data:
            r = sendit(w3, contract.functions.updateSymbolData(i, symbol_data[i]).build_transaction(), nonce)
            print(f'sent tx {r.hex()} with nonce {nonce}')
            nonce += 1
        r = sendit(w3, contract.functions.updateTulipData(tulip_data).build_transaction(), nonce)
        print(f'sent tx {r.hex()} with nonce {nonce}')
        nonce += 1

    # Parse SVG data
    if getenv('SVG'):
        _npc = contract.functions.numPaletteColors().call()
        _nsm = contract.functions.numSymbols().call()
        _ntp = contract.functions.numTulipParts().call()
        print(f'[+] Found {_npc} palette colors, {_nsm} symbols, and {_ntp} tulip pieces on the contract')
        ts = contract.functions.totalSupply().call()
        print(f'[+] Found total supply of {ts}')
        for i in range(1, ts + 1):
            r = contract.functions.tokenURI(i).call()
            data = json.loads(b64decode("".join(r.split(',')[1:])))
            with open(f'outs/{i}.json', 'w') as _f:
                _f.write(json.dumps(data))
            svg = b64decode("".join(data['image_data'].split(',')[1:]))
            with open(f'outs/{i}.svg', 'wb') as _f:
                _f.write(svg)
