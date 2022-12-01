#!/bin/bash

export CONTRACT=0x5FbDB2315678afecb367f032d93F642f64180aa3
source .env
forge create NFT --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY --constructor-args NFT NFT
# cast send --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY $CONTRACT "mint()"
# cast call $CONTRACT "tokenURI(uint256)" 1
# cast call $CONTRACT "tokenURI(uint256)" 0


# Setup SVG data
# for i in data/Tulip/*svg; do cat ${i} >> cmd.sh; echo -e "\n" >> cmd.sh; done

cast send --rpc-url=$LOCAL_RPC --private-key=$LOCAL_KEY $CONTRACT "updateTulipData(string[])" "[<linearGradient id='a' gradientUnits='userSpaceOnUse' x1='400' y1='1146' x2='400' y2='54'><stop offset='.002' id='startGradient'/><stop offset='1' id='stopGradient'/></linearGradient><path style='fill:url(#a)' d='M50 54h700v1092H50z'/>,<path class='blb' d='M419.7 362.4c-5 4.3-4.8 18.5 4.3 17.1 2.3-.3 4.2-2 5.3-4s1.3-4.4 1.1-6.7c-.2-2.3-.9-4.5-1.6-6.7 2.9-.6 6-1.4 8.5-3.1 2.4-1.7 4.1-4.9 3.2-7.7-1-3-4.6-4.5-7.7-3.9-3.1.6-5.6 3-7.3 5.6-.8-2-1.1-4.4-3.5-5.2-1.8-.6-3.8-.1-5.2 1.1-4.5 3.9-2.4 11.6 2.9 13.5z' />,<path class='stm' d='M430.3 370.4c.5.5 1 .9 1.4 1.4.4.5.7.9 1.3 1.2 1 .7 2.3.9 3.4 1.3 7.5 2 14 6.8 21.4 8.9 2.4.7 4.9 1.1 7.3 1.2 2 .1 1.6 2.7 6 2.4-7.7-5.5-14.4-10.6-20.1-18.3-2.2-3-3.5-7-6.1-9.5-4.1-4-11.8-4.5-15.3.5-3.1 4.3-2.3 7.9.7 10.9z'/><path class='shdw' d='M430.1 370.5c1.7 1.8 4 3.1 6.2 3.7 7.5 2 14 6.8 21.4 8.9 2.4.7 4.9 1.1 7.3 1.2 2 .1 1.6 2.7 6 2.4-.9.1-3.2-2.4-4-3-1.2-.8-2.4-1-3.7-1.5-3-.9-6-2.1-8.3-4.3-2-1.9-3.6-4.5-6.3-5.1-3-.6-6.1 1.8-8.7-.3-5.6-4.7-5.2-13 .4-12.7 3.4.2 5.7 5.6 9.1 6.3-4.4-8.2-4.7-9.1-9.1-10.3-6.1-1.6-13.5 2.3-12.9 9.3.3 2.2 1.3 4 2.6 5.4z' style='opacity:.25;fill:#231f20'/>,<path class='fr' d='M398.6 385.4c-2 3.3-.5 9.1 4.1 6 1.3-.9 2.2-2.2 3.3-3.4 2.2-2.5 5-4.4 8-5.5 1.2-.4 2.5-.8 3.7-1.4 1.2-.6 2.2-1.5 2.7-2.7 2.1-6.1-7.6-3.3-10-2.4-4.9 1.8-9.1 5.1-11.8 9.4zm20.8 17.5c-.7 2.6.9 6.8 3.9 3.7.7-.7 1.1-1.7 1.6-2.6 1.6-3.1 4-5.7 6.9-7.6 1-.7 2.1-1.2 3-2.1 1.9-1.8 2.2-5.5-1.2-5.1-2.4.3-5 2.2-7 3.6-3.5 2.4-6 5.9-7.2 10.1zm-13.9-43.7c-3.8-3.4-5.9-8.2-7.3-13.1-.5-1.7-.8-3.8.6-5 1.6-1.3 4-.1 5.4 1.4 3.6 3.7 5.2 9.1 9.2 12.5 1.8 1.5 9.2 5.9 4.2 7.4-4.1 1.3-8.9-.4-12.1-3.2zm14-32.2c0-1.1 0-2.3.8-3 .8-.7 2.1-.6 2.9 0s1.4 1.5 1.9 2.5c3.9 7.6 4.9 16.6 2.6 24.8-.3 1.2-.9 2.5-2 2.8-1.1.3-2.3-.6-2.8-1.7-.7-1.6-.4-3.5-.9-5.2-.7-2.1-1.3-4.3-1.6-6.5-.7-4.5-.8-9.2-.9-13.7zm13.4 18.6c.5 1.1 1.3 2.3 2.4 2.8s2.9.1 3.1-1.2c.1-1.1-.5-1.5-.7-2-2.6-5.1-3.4-11.9-7.3-15.5-.8 4.9.3 11.5 2.5 15.9z' />,<path class='flwr' d='M520.3 328.9c-1-4.8-4.4-8.8-6-13.3-.1-.3-.2-.7-.3-1.1-1.2-4.8.8-10.8-.6-15.6-.7-2.5-2.1-4.7-3.6-6.8-5.5-7.5-2.9-13.5-8-15.6-.1.2-.1.4-.2.7-1.5-2.3-2.9-4.6-4.1-7-2.2-6-4.2-12.7-3.1-18.9.9-4.9 3.9-9.4 4.5-14.3 1.1-2.1 2-4.2 2.6-6.4 1.1-4.5.7-9-.3-13.6-1.7-9.2-2.6-16.9-2.7-24.7 0-7.8-.6-16-4.3-22.8-2.1-3.8-5.2-7.5-8.3-10.5-.4.9-.7 1.6-.7 2.6 0 .6.1 1.2.2 1.8-9.5 2.4-17.2 9.2-24.4 15.8-2.1 1.4-4 3.8-5.4 5.2v.1c-1.8 2-3.5 4.1-4.7 6.5-1.6 3.2-2.4 6.8-3.7 10.2-1 2.5-2.3 4.9-3.8 7.2-.1-.1-.1-.3-.2-.4-1.8.6-3.2 2.3-3.9 4.1-.3.9-.6 1.8-.7 2.8l-2.4 3c-1.1-9.5-4.7-19.3-12.3-24.8-1.4-1.6-3.4-2.7-5.2-3.3-1.2-.4-2.5-.5-3.7-1-1.8-.7-2.2-2.7-3.7-3.3-1.2-2.4-2.3-5.1-2.8-7-1-3.2-2.9-6.6-6.1-7.5-1.2-.3-2.5-.3-3.7-.8-1.8-.8-2.7-2.8-4-4.3-1.5-1.9-3.5-3.1-5.6-3.9-.1-.2-.2-.4-.4-.5-.3-.3-.7-.4-1.1-.6-2.6-1.2-5.3-2.1-7.4-4.2-1.5-1.5-2.7-3.4-4.3-4.9-1.1-1-3.4-2.3-4.9-1.7-2.2.9-1.1 1.9-.5 3.7.3 1.1-.3 2.2-1.2 2.9s-1.9 1-2.9 1.6c-3.2 1.8-4.8 6.1-3.8 9.6-.6 2.1-.8 4.4-1.5 6.4-1.3 3.6-4.1 6.5-6.2 9.6s-3.7 7.6-2.3 11.2c-1 5.5-1.4 11.7 1.1 16.9.3.7.7 1.3 1 1.9.1.5.3 1.1.6 1.6.5 1.1.6 2.4.5 3.7-.2 2.1-.6 4.2-.8 6.2-.1.6-.3 1.3-.4 1.9-.6 4.3-1.3 8.5-1.5 12.9-.1 2.2.1 4.4.6 6.6-1.1 5.9.2 12.5 4.9 16.5 2.1 1.8 4.4 3.4 5.9 5.9 1.6 2.6 2 6 2.6 8.9.5 2.5 1.1 5 2 7.3.9 2.4 2.2 4.7 3.3 7.1.1.2.2.4.4.5h.1c.6 1.2 1.4 2.3 2.3 3.2 2.6 2.5 5.4 4.4 7.6 7.4 3.7 5.3 4.4 12.5 8.8 17.4-.1 0-.2-.1-.3-.1l-.1-.1c-1.4-.9-1.4-.7-2.1-.8-.7-.3-1.3-.5-2-.7-.1-.1-.3-.1-.4-.2v.1c-1.3-.4-2.5-.8-3.8-1.2-1-.9-2.1-1.7-3.2-2.4-5.4-3.4-18.2-1.6-24.5-1.7h-.3c-3.6-.6-7.2-1.2-10.9-1.5-6.7-.6-13.6-.8-19.8 1.5-6.7 2.5-12.1 7.6-18.4 11-2.5 1.3-5.1 2.4-7.8 3.4-6.6.5-13.2 4.4-18.2 8-.6.4-1.2.9-1.7 1.4-12 9.7-16.8 26.4-21.8 41.4-3.1 9.2-8 19.4-16.9 22.5-1 0-2-.1-3-.2-1.7 4.7 16.6 6.3 24.4 1.7 3.6-2.1 7.2-5.5 11.4-5.6 4.8 0 11.4 5.6 16.2 5.9 4.1 1.1 8.4 1.1 12.6.9 5.1-.2 10.2-.7 15.3-1.4 8.6-.8 11 .1 14.9-2.7 4.6-1 9.3-1.9 14-2.1 12.8-.8 26.3 3.7 39 2.7-3.9.8-7.9 1.8-11.1 3.6-2.9 1.6-5.7 3.2-8.7 4.7-3.1 1.6-6.9 2.4-9.8 4.2-2.9 1.7-5.4 4.3-7.8 7-.2.1-.3.2-.5.3-2.3 1.3-4.6 2.7-6.7 4.3-3.2 2.4-6.5 2.9-10.2 4.2-6.1 2.2-10.8 6.9-13.1 14.4-.4 1-.7 1.9-1 2.9-1.3 4.5-2 9.3-4.5 13.3-1.9 2.9-4.7 5.5-4.9 9-.1 2.7 1.5 5.3 1.5 8 .1 3.6-2.5 6.7-3.5 10.2-1.6 5.4.7 11.1 1.9 16.6 1.5 7.4.9 15.2-1.7 22.2 3.2-.8 6.4-1.4 9.3-2.7-.1.1-.2.1-.3.2 7.9 1 15.9-2.3 22.5-6.3 3-1.8 5.8-4.6 9-6 5.2-2.2 10.2-1.4 14.5-5.7 2.3-2.4 4.4-5.2 7.4-6.5 1.3-.6 2.8-.8 4-1.4 2.4-1.1 4.9-5.1 5-6.5.9-1 1.7-2.1 2.4-3.4 1.3-2.5 2.5-4.5 5.2-5.7 4.9-2.1 5.5-5.6 8.3-9.8.5-.8 1.2-1.6 1.9-2.2 3.6-.6 5.1-2.5 7.8-5.8.4-.3.9-.6 1.3-.9 3-2.2 5.6-5 7.6-8.1 2.5-1.6 4.2-4.3 5.8-6.8-.5 2-.7 3.8-.9 5.9-.1 2 .2 4.1 1.3 5.9l.1-.1c1.4 2 4.4 2.6 5.2 4.8.2.5.2 1.1.4 1.6.4.9 1.3 1.4 2.3 1.6 3.8.7 5.9.1 7 3.7-.5 3-1.2 6-2.2 8.9-.1.1-.2.2-.4.3 2 1.9 5.2 2.1 7.9 1.5 2.2-.5 4.2-1.4 6.4-2 1.6-.3 3.4-.6 3.4-.6v-.1c3.1-.3 6.3.2 9.3 1 1.8 1.4 3.6 1.5 5.1 1.5 2 .6 3.9 1.3 5.5 2.6 1.5 1.3 2.5 3.1 3.9 4.6 2.7 3 6.5 4.5 10.4 5.6 2 .5 3.9 1.7 5.7 2.7 1.7 1 3.7 1.7 5.5 1.4.3-.1.5-.5.3-.8-.9-1.2-.8-3.2 0-4.6.9-1.6 2.5-2.6 3.8-3.9 3.3-3.2 3.6-8.1 3.7-12.7.5-17.3-1.3-22.5-3.3-28.5-1.1-3.3-2.6-6.7-3.1-10.1-.3-1.8-1-7.6 1.2-8.2.9-.2 2-.2 2.6-.8.6-.5.7-1.4.5-2.2-.3-1.3-1.1-1.8-.9-2.9 1.2-.9 2.6-1.3 3.9-2 1.5-.8 2.8-1.8 4-3 2.6-2.6 4.2-6 5.4-9.4.4-1.1.3-2.2.5-3.3.4-2.8 1.6-5.6 2.2-8.4.6-2.8 1.1-5.7 1-8.6 0-1.3-.8-5-.8-6.4-.2-.1-.4-.1-.6-.1-.1-1.2-.1-2.6 0-4 .3-.4.7-.8 1-1.2 4.5-5.2 6.2-10.6 6.5-19.1.1-3.6-.3-7.1-1.1-10.5 1.9-6.5 3.2-13 1.8-19.3z' />,<g style='opacity:.8'><path class='lnng' d='M454.8 373.4c2.5-2.7 7.3-3.4 11-3.5 10.9-.3 21.5 2.2 30.9 7.7-11.1-9.4-19.6-19-31.6-24.8 4.4-.3 8.9.9 12.4 3.6-6.4-5.1-13.2-8.7-21-13.4-5.3-3.2-14.7-1.7-18.7 2.1 7 8 9.1 21.3 17 28.3zM427 316.3c4.4-2.1 9.6-1.8 14.2-.2s8.7 4.4 12.7 7.2c-1.6-3.2-3.7-6.1-6.1-8.7 5.8 2.2 11.4 5.4 16.2 9.4-2.5-4.3-6.7-7.1-10.5-9.9-3.2-2.4-5.7-5.5-8.6-8.2-3.1-2.9-6.5-3.5-10.7-3.8-2.3-.1-4.9-.2-6.8 1-.3.2-.5.6-.5 1 .2 4.3.5 8 .1 12.2zm71.3-9.5c-1.4-3.3-1.2-8.7-2.6-12-2.7-6.3-3.1-8.1-8.2-13.3-2.2-2.3-4.9-3.9-7.9-4.9-1.8-.6-3.4-1.3-5.2-2-2-.8-4-1.8-5.8-3-2.5-1.7-6.5-3.9-10.4-4.8-5.3-1.2-15.7-1.6-21.2-1.6-1.8 0-3.6.2-5.4.3-1.8-.1-3.5-.1-5.3-.1l.2.1c-1.4-.1-2.8-.3-4.1.2-.7.3-1.4.9-1.5 1.7-.1 1.3 2.4 2.3 3.2 3.1 1.2 1.3 2.3 2.8 2.9 4.4 1.5 3.5-.7 6.9 1 12 3.1 0 5.1.4 7.9 1.8s5.7 3.4 8.2 5.2c1-3.6-8.9-8.7-10.1-10.8.1.2 5.9 2.4 7 3.1 2.5 1.6 4.9 3.3 7.1 5.4-2.3-2.9-4.1-5.7-6.4-8.6 9.6 6.3 17.6 15.1 22.9 25.2 1.2 2.3 2.8 4.7 5.3 5.3 2-3.8 2.3-8.3 1.3-12.5-1.5-6.6-5.5-12.2-9.3-17.6 2.1.9 4 2 5.8 3.4.7-1.9-9.9-14.5-6.2-11.2l14.4 15.3c-1.1-6.7-4.8-12.3-10.1-16.4 5.3.9 11 5.1 14.2 9.2 2.9 3.8 6.9 12.3 6.4 17.2.5-4.4.2-8.9-1.3-13 3.8 4.6 4.7 10.7 6.6 16.4 1.8 5.5 8.6 9.9 16.3 18.4-2-3.9-8.6-13.5-9.7-15.9zm14.6 76c0 1.3.8 5.1.8 6.4.1 2.9-.3 5.8-1 8.6-.6 2.8-1.8 5.6-2.2 8.4-.2 1.1-.1 2.2-.5 3.3-1.2 3.4-2.8 6.8-5.4 9.4-1.2 1.2-2.6 2.2-4 3-1.4.8-2.9 1.2-4.1 2.2-5.1-.4-9.8-4-11.4-8.8 1 1.9 3.3 2.9 5.4 2.5-4.8-4.1-7.7-10-8.9-16.2 3 5.2 7.9 9.1 13.4 11.7-1.3-2.2-3.4-3.8-5.2-5.7-1.8-1.8-3.1-4.3-3-6.8 1.1 1.8 2.3 3.5 3.7 5 1.4 1.5 3.4 2.8 5.5 3.3-2.4-1.6-3.9-3.8-5.2-6.3-1.4-2.6 1.7-.4 2.7 0 1.1.4 2.2.7 3.4.8 1.2.1 2.3.1 3.5-.1.8-.1 2.3-1 3-.9-2.7-.5-10.2.8-6.7-.9 2.6-.9 3.9-1.3 6.3-2.4 2.3-1 8.2-7 5.4-4.9-5 2.6-11.6 2.2-7.4.5 4.9-2.7 6.5-5.1 9.6-9.7.9-2.2 1.4-2.7 2.3-2.4zm-36 17.4c-2.5 2.9-4.3 6.5-5.1 10.2-.7-3.2.9-7.1 2-9.5.6-1.9-8 7.1-8.6 12.2-.7-3.7.2-8.2 2.5-11.2-9.8 4.1-9.8 17.4-9.6 26.5-3.1-5.2-4.9-11.4-4.2-17.5-3.4 2.6-4.4 12.9-4.5 20.7-2.1-4.1-2.6-9.1-2.6-13.6 0-1.9.2-3.8.3-5.8.1-1.8.5-3.5 1.4-5.1.9-1.7 2.1-2.6 3.8-3.6 2-1.1 3.7-1.2 6-1.2 1.6-.1 3.2-.4 4.7-.9 2.1-.8 4-1.2 6.3-1.3 2.4 0 5-.1 7.6.1zm-34.4 12.5c-5.5 3.8-10.1 9-13.2 15-1.3 2.5-2.3 5.2-3.7 7.7-1.5 2.8-3.7 4.8-5.9 7.1-.5.5-1 1-1.6 1.4-.7.3-1.5.4-2.2.4-2.5.1-4.9.6-7.5.7-2.6.1-5.3.4-7.8 1.4-1.7.7-3.7 1.6-5.1 2.8-1.4 1.2-2.5 2.6-4 3.7-1.2.9-1.6 2-2.6 3 .4 1.6 1.9 2.4 3.5 2.9 3.2 1 6.7 1.1 10 .3-2.9-.2-6.5-1.1-8.2-3.4 5-.7 10 1.5 14.6-.5 3.1-1.4 5.1-4.5 6.9-7.4-.5 2-.7 3.8-.9 5.9s.2 4.1 1.3 5.9c5-5.3 10.1-11.3 11.6-18.4.7-3.5.5-7.4 2.2-10.6 3.2-6.5 7-13.3 12.6-17.9zm-13.6 35.2c3.7 10.4 3.7 22.2-.2 32.6 1.8.7 4.1-.5 5.1-2.1s1.2-3.6 1.2-5.5c.1-8.9-2.6-16.8-6.1-25zm13.6 5.3c3.7 3.8 7.4 7.6 10 12.2 2.6 4.6 4.1 9.6 2.9 14.7 1.9 1.6 3.7 1.6 5.3 1.6-.4-5.2-2.2-11.9-4.8-16.5-3.1-5.4-7.6-9.9-10.7-15.3-3.6-6.3-4.8-10.7-5.7-19.2-.9-6.8-1.3 23.8 2.5 36 .7 2.2 1.6 4.4 1.5 6.6-.1 1.8-1.1 3.1-2.3 6.9 1.6-.2 5.1-.9 5.1-.9 0-1.4-.6-3.3 0-4.6 1.2-2.9.5-5.7-.3-8.6-1.1-4.2-2.9-8.7-3.5-12.9zm19.3-12.9c1.2 5.8 3.9 11.2 6.9 16.3 3.3 5.7 6.8 11.2 8.9 17.5 2.2 6.5 3.2 13 2.4 19.8 0 .3.1.5.4.5 2 .5 3.9 1.7 5.7 2.7 1.7 1 3.7 1.7 5.5 1.4.3-.1.5-.5.3-.8-.9-1.2-.8-3.2 0-4.6.9-1.6 2.5-2.6 3.8-3.9 3.3-3.2 3.6-8.1 3.7-12.7.5-18.7-1.6-23.3-3.8-30-.9 2.6.8 2.8.1 4.4-2.9-2.2-6.9-4.7-10.4-5.9 1.6 1.3 2.8 2.9 3.8 4.7-3.6.4-7.4-1-10-3.5-.3-.3-.8 0-.6.4 1.7 3.5 5.4 7.6 8 11.1-6.1-3.7-11.3-6.8-15.6-12.8 1.7 7.7 8 14.4 14 21.1 1.4 1.1 2.2 1.9.5 1.2-6-2.1-10.4-7.2-14.1-12.3-4.2-5.9-7.7-12.2-10.5-18.9.1 2 .6 2.6 1 4.3zm-78.3 22.9c1.8 1.8 4.4 2.9 6.9 3 2.6.1 8.5-1 10.5-2.7-3.5 4.4-5.1 6.3-12.2 6-2-.1-3.9-.2-5.9-.4-.8-.1-1.3-.9-1.1-1.6.4-1.5 1.1-3.1 1.8-4.3z'/><path class='lnng' d='M501.8 276.5c-1.7 5.4-2.6 11-2.6 16.6 0 2.9.2 5.7.6 8.5.2 1.5-.5 4.3 2 6-.8-2.3-.7-4.9-.7-6 0-.7.1-1.6.8-1.8 2.1-.4 2.7-.1 2.9 2.1.3 3.5.5 7 .8 10.5 1.1-.5 1.6-1.8 1.8-3 .8-4.3 1.3-8.6 1.6-13 1.5.6 2.5 2.2 2.8 3.8.3 1.6 0 3.2-.3 4.8-.3 1.6-.7 3.2-.5 4.8.2 2.5-.3 6.3 4 7-2.8-5.1.2-12.3-1.4-17.9-.7-2.5-2.1-4.7-3.6-6.8-5.7-7.5-3.1-13.5-8.2-15.6zm-2.9-40.8c-2.6 4.3-7.6 6.8-9.9 11.3-1.9 3.7-.8 8.2-.9 12.4-.1 5.6 1.8 10.1.7 14.2 2.2-2.8.8-4 1.7-5.2.9-1.1 2.4-1.9 3.8-1.5 1.5.4 2.4 2.3 3.1 3.6-2.2-6-4.3-12.8-3.2-19.1 1.1-5.4 4.6-10.3 4.7-15.7zm-24.4 34.9c0 .7-.6 1.3-1.2 1.3-.2 0-.3.1-.5.1-.5.2-1 .7-1.4 1.1-2-.5-3.8-1.9-5.5-3.1-2.2-16.2 4.7-32.4 9-47.8 4.6-16.3 9.7-43.3 10.4-49.7 1.7 7.3 1 15.7.1 23.4-.6 4.8-1.9 9.5-3.1 14.2-2.6 9.9-4.9 19.9-6.3 30.1-.7 5-1.3 10.1-1.3 15.2-.2 5.1.1 10.1-.2 15.2zm-63.4-85.1c-1.7 4.3-2.2 9.1-2.6 13.6-.2 2.2.4 4.4.5 6.6 0 1.5-2.2 4.4-.3 6 1.2-3.1 2.3-6.2 3.5-9.3.2 7.4-.8 14.8-2.9 21.9 2.4-1.7 4.4-6.1 5.7-9.5-.3 9.9.5 19.7 2.6 29.4 1.4-10.8 2.3-21.6 3.1-32.5.2-2.1-.5-6.7 1.6-8.1.9-.5 1.9-.9 2.5-1.7 1-1.5.6-5.6 0-7-1-2.5-4-4.5-6.4-5.2-1.2-.4-2.5-.5-3.7-1-1.7-.6-2.1-2.6-3.6-3.2zm-24.6-23c-1 .1-1.8.4-1.5 1.4.1.4.3.8.3 1.3 0 .4-.3.7-.6 1-1.8 1.5-1.5 4-1.3 6.2 1 10.6 2 21.1 3.1 31.7-1.7-1.4-2.1-5.4-4.3-11.7-1.1-2.2-3.3-12.3-4-14.7-.7-2.1-1.6-4.1-2.8-5.9-1-1.5-1-.6-.8.7.2 1.2.5 2.3.8 3.5.3 1.2 2.6 4.3 1.1 3.7-1.4-.5-3.2-2.7-4.1-4.5-.9-1.9-2.1-3.8-3.8-5.1-1.7-1.4-4-1.5-6.1-1.5-1.7-3.6 0-8.5 3.4-10.5 1-.6 2-.9 2.9-1.6.9-.7 1.5-1.8 1.2-2.9-.6-1.8-1.7-2.8.5-3.7 1.6-.6 3.8.7 4.9 1.7 1.6 1.4 2.8 3.3 4.3 4.9 2.1 2.1 4.8 3 7.4 4.2.4.2.8.3 1.1.6.3.3.5.7.5 1.1-.2.2-1.3.1-2.2.1zm-28.2 24.6c-1.1.1-1.7 1.5-1.5 2.6.3 1.1 1.1 1.9 1.9 2.7 2 1.9 4.2 3.6 5.8 5.8.9 1.2 2 2.3 3.1 3.4.6.5 1.3 1 1.8 1.5.6.6 1.1 1.1 1.2-.1.1-1.2-.9-2.5-1.5-3.5-.9-1.3-2-2.5-3.1-3.7-1.6-1.7-3.2-3.5-3.9-5.8-.4-1.8-1.7-3.1-3.8-2.9zm32.2-17.1c-1.9 2.2-2.2 5.3-2.3 8.2 0 3.9.8 10.7 1.6 10.7s.2-6.9.3-10.8c.1-1.1.1-2.3.7-3.3.6-1.1 1.6-1.6 2-2.8.2-.6.1-1.4-.3-1.9s-1.6-.6-2-.1zm52.5 38c-1.8.6-3.2 2.3-3.9 4.1s-.9 3.8-.9 5.7c-.3 15.3 5.2 30 10.7 44.2-1.4-6.4-2.1-13-2.8-19.6-.4-3.3-.7-6.5-1.2-9.8-.1-.7-1-2.8-.8-3.5.4-1.1 1.2-.6 1.7.2.6.9 2.2 3.8 2 4.9 1.3-8.3-1.6-18.4-4.8-26.2zm12.5-23.6c1.4-1.4 3.2-3.7 5.4-5.2.1 0 .1 0 .2.1 3.6 8.1 5.5 18.3 3.4 26.9-.9-2.4-1.5-5.1-2-7.6.4 7.6.9 21.1-1.7 22.8 0-9.4-2.6-12.8-3.4-23.1-.2-2.1-2.4-6.8-2.2-9 .1-1 .6-1.9.6-2.8 0-.3-.5-1.9-.3-2.1zm29.6-22.8c-.1 6.4 7.2 11 7.5 17.5.2 2.9-1.1 5.9-.4 8.7.5 1.8 1.7 3.4 2.5 5.1 1.7 3.6 1.6 7.7 1.8 11.7.2 4 2.1 6.7 4.7 12.7-1.7-9.4-2.7-17.2-2.7-25 0-7.8-.6-16-4.3-22.8-2.1-3.8-5.2-7.5-8.3-10.5-.4.9-.8 1.6-.8 2.6zM355 212.8c1.8-.2 3.9-.2 5.5.6 1.9 1 3 2.9 4.2 4.7 2.1 2.9 4.9 5.3 7.3 8s4.6 5.8 5 9.4c-1.7-2.6-3.8-4.9-6.3-6.7-.3-.2-.5-.4-.8-.3-.5.1-.7.6-.6 1.1s.4.8.7 1.2c2.1 2.6 3.5 5.7 4.1 9-4.4-4.8-8.8-9.8-13.2-14.6-.7-.8-1.5-1.6-2.5-1.7-1.4-.2-2.7 1.1-3.6 2.1.2-2.1.7-4.2.8-6.3.1-1.2 0-2.6-.5-3.7-.7-1.3-1.2-2.7-.1-2.8zm46.1 62.7c2.6 5.9 6 11.6 9.8 16.9-1.7-6.6-2.6-13.4-3.5-20.2 2.4 6.9 5.7 13.5 9 20 .5-3.8.2-7.9-1.1-11.6.5 1.5 2 3 2.7 4.4.4.8 1 1.5 1.2 2.4.2.9 0 1.8.2 2.7.4 1.6 1.7 1.3 2.6 2.4.8 1-.1 2.7-.1 3.8 0 1.9 1.5 2.1 2.3 3.6.6 1.2.5 2.4.5 3.6 0 .9.2 1.8.2 2.7 0 .9 0 1.8-.1 2.8-.1.7-.2 1.1-.5.2-.6-2.1-.8-3-1.8-4.2-.1 3.1-.6 6-1.4 9-1.1-2.6-.5-3.5-1.4-5-2.5 2 3.1 14.4 1.7 14.7-9.5-13.8-16.5-29.4-20.5-45.7-.1-1 .2-1.7.2-2.5zm-9 25.6c-.7.2-1.5.2-2.2 0-1.8-.4-3.4-1.5-4.8-2.7-.9-.7-1.6-1.6-2.4-2.3-.7-.6-1.5-1.1-2.2-1.6-.6-.4-1.2-.8-1.9-1-1.7-.5-3.6-.1-5.3-.2-.2 0-.5 0-.7-.2-.2-.1-.3-.3-.4-.5-1.1-2.4-2.4-4.7-3.3-7.1-.9-2.4-1.6-4.8-2-7.3-.5-2.9-1-6.4-2.6-8.9-1.5-2.4-3.8-4-5.9-5.9-4.7-4-6-10.6-4.9-16.5 4.3.7 8.4 2.5 11.6 5.4 3.5 3.3 6.2 7.3 9.1 11.1 6.5 8.7 13.9 16.6 20.9 24.8 6.7 7.8 12.1 17.1 16.6 26.4-7.6-7.4-15.7-14.7-23.3-22.1-2.5-2.4-5.3-5-8.7-5.1-.5 0-1.2.2-1.2.7 0 .3.2.5.4.7l7.2 6.3c2.3 2 4.7 3.8 7 5.7-.3 0-.7.2-1 .3zM236.2 401.2c4.4.7 9.1-.1 13-2.3 3-1.6 5.5-4 8.6-5.3 4.7-2 10.2-1.5 15 .4 4.8 1.9 11.5 6.3 15.6 9.3-4.8-.3-11.5-6-16.3-5.9-4.2 0-7.8 3.4-11.4 5.6-7.9 4.5-26.2 2.9-24.5-1.8zm269.9-35.5c-2.2-4.9-5.5-9.1-8.8-13.3-4.5-5.8-9-11.6-13.6-17.3 11.2 10.7 22.9 22.2 26.8 37.1-.8-10.6-5.7-20.9-13.3-28.3 8.8 5.4 12.7 16 16 25.9-.8-2.2-.2-5.4-.8-7.8-1.9-8.2-7.7-14.9-12.4-21.7 6 3.3 9.6 8.7 12.5 14.6.7 1.5 3 6.5 2.7 8.1 3.8-2 0-21-2.2-32 3.4 8.9 7 18 6.7 27.5-.2 8.5-2 13.9-6.5 19.1-8.1 9.5-4.5 4.4-5-.2-.3-4.2-.4-7.7-2.1-11.7zm-184 149.4c3.1-3.8 6-8 10.3-10.4 5.5-3.2 12.2-2.9 18.5-3.6 9.3-1.1 17.1-4.7 24.5-10.5-.1 1.4-2.7 5.4-5 6.5-1.3.6-2.7.9-4 1.4-3.1 1.3-5.1 4.1-7.4 6.5-4.2 4.4-9.2 3.5-14.5 5.7-3.2 1.3-5.9 4.1-9 6-6.7 4-14.6 7.3-22.5 6.3 3.1-2.7 6.4-4.6 9.1-7.9zm30.4-197.9c8.1 10.1 19 18 31.2 22.3 7.1 2.4-10.9-7-10.1-11.1 8.6 4.6 17.2 9.3 25.8 13.9-2.3-3.1-4.7-6.1-7-9.2 1.8-.6 7 4.5 5.5 2.6-2.4-3-4.8-6-7.2-9.1-3.3-4.1-6.7-8.3-11.1-11.2-5.4-3.4-18.2-1.6-24.5-1.7-4 0-7.4-2.5-2.6 3.5zm33.9 1.8c3.7 6.2 9.7 11.7 15.7 15.6-2.2-3.2-4.1-6.5-6.4-9.7 6.7 3.1 12.9 6.8 18.6 11.4-3.5-3.6-7.5-6.7-11.7-9.5-1.7-1.1-4-3.1-6.1-3.6-1.9-.5-2.7.6-4.4-.9-.6-.5-.7-1.2-1.3-1.6-2.1-1.3-.8 0-4.4-1.7zm-74.3 3.3c2.8 4.6 7.5 7.8 12.4 9.8 5 2 10.3 3 15.6 3.9-6.6-3.2-13.1-7.2-19.1-11.5-2.5-1.9-5.8-3.1-8.9-2.2zm42.2 4.5c-.6-5.7-5.3-8.3-7.3-13.3.2.5-.8 1.8-.9 2.3-.7 3.9 5.8 8.6 8.2 11zM277 338.7c0 .1-.1.2-.1.3-1.1 2.7 2.2 3.6 4 4.7 6.7 3.8 14.3 6.1 22 6.6-4.7-1.6-9.3-4-13.5-6.6 1.9 1.2 5 1.7 7.2 2.3 2.4.7 4.7 1.5 7.1 2.2 5.4 1.6 10.9 2.5 16.5 2.7-6.2-1.9-12.3-5-17.7-8.8 8.4-.3 16.1 4.3 24.2 6.6 18.1 5.2 38.1-.4 56 5.5-3.4-1.1-6.8-2.9-10.2-4.1-3.3-1.2-6.5-1.2-10-1.4-8.1-.6-16.1-1.9-24-3.8-9-2.1-17.9-4.1-25.4-9.8-2.8-2.2-5.4-4.8-8.8-6-8.5-3-18 2.5-24.7 7.2-1 .5-2.1 1.3-2.6 2.4zm38.5 64.1c-.6-6.2 4.5-12.7 9.8-16 5.3-3.3 22.5-8.4 17.6-5.6-4.3 2.9-8.1 6.7-11.2 10.9 4.3-2.4 8.9-4.4 13.6-6.1 6.5-2.3-6.4 4.2-9.6 6.2-1.4.9-2.9 1.8-3.9 3.1s-1.5 3.2-.8 4.7c-4 2.9-6.3 1.9-15.5 2.8zm-51.6-35c1.2 2 3.5 3 5.7 3.6 7.4 2.1 15.5 1.4 22.4-2-3.8 1.4-8.2 1-12.2.5-5.1-.6-10.8-.6-15.9-2.1zm57.6-3.8c18.6-3.1 37.8-1.7 55.8 4-2.7 2.1-5.8 2.4-9.1 2.8-7.9.9-15.9 1.7-23.8 2.6 4.9.1 9.8.8 14.7.4 4.7-.3 9.5.1 14.2.9 1.7.3 3.7.4 5.4.8 2.1.5 4.2 1.9 6.3 2.6 5.1 1.8 6.6 2.1 11.9 3 6.5 1.1 13-1.1 18.5-4.7 0-.8-.7-1.3-1.3-1.7-4.1-2.7-8.3-5.3-12.6-7.6-4.3-2.3-8.6-4.6-13.5-4.5-1.5 0-3 .2-4.4-.2-1.2-.4-2.3-1.2-3.4-1.8-2.2-1.3-4.8-1.9-7.4-2-2.5-.2-5.1-.1-7.6.3.5.2 3.1 1.3 3.9 1.5 1.5.3 6 1.2 6 1.8 0 .6-.8.5-1.2.5-10.4-2.3-21.2-3.4-31.9-3.1-3.6.1-7.1.3-10.6 1.1-3.4.7-6.9 1.5-9.9 3.3zm38.1 33.4c2.2-5.3 7.4-8.8 12.9-10.4 5.5-1.6 11.3-1.4 17-1.2-4.4 1-8.5 3.4-12.2 6.2 2.3-.8 4.9-.9 7.3-.8-2.6-.2-5 4.3-7.2 5-2.9.9-6.9-.5-10 .1-2.7.5-5.2 2.1-7.8 1.1zm32 .8c6.8 2.6 14.4 6.1 19.6 4.2 3.3-1.2 6.7-1.9 10-2.8-4.3.6-8.7.5-13.1.6-2.3 0-4.6-.3-6.8-.7-1.6-.3-6.3-1.3-9.7-1.3z'/><path class='lnng' d='M266.1 367c.9-.1 2.2.3 2.8.5 2.9 1.2 6 1.7 9.1 2.1 4.2.5 10.4 1.2 14.5-.3-6 2.2-12.5 3.5-18.9 2.9-2-.2-4.1-.8-5.9-1.6-.8-.4-2.2-.9-2.6-1.8-.5-1.3.1-1.8 1-1.8zm83.3 51.9c-1 .1-1.9.7-3.4 1.5-2.3 1.3-4.6 2.7-6.7 4.3-3.2 2.4-6.5 2.9-10.2 4.2-6.1 2.2-10.8 6.9-13.1 14.4 4.5 2.1 9.1 2.3 14.1 2 5-.3 9.8-1.4 14.7-2.5-4.1-.4-10.4.7-12.6-1.6 3.4-1.8 7.7-1.1 11.6-1.2s7-2.1 10.2-4.3c0 .1-9.1 0-12.8 0 2.4-1.4 5.9-2.8 8.7-3 2.7-.2 5.5-.2 8.2-.8 2.7-.6 5.3-2 6.8-4.3-2.2-.2-4.4-.3-6.6-.5 1.1.1 3.8-1.9 5-2.3 2-.6 4.2-.6 6.2-.8 1.4-.1 2.7-.3 4-.7 1.3-.4 2.5-1.2 3.3-2.3-6.8.3-15.9.2-22.7-.1-2.6-.1-2.3-2.1-4.7-2zm-40.9 52.8c9.4 1.9 19.5-.1 27.4-5.3.2 1-1.6 2.7-4.1 4.8 0 .2-.8.7-.9 1 .8.1 5.4-2.6 6.8-3.4-1.8 2.1-4.1 3.7-6.6 4.9-2.5 1.2-5.1 2-7.8 2.8-2 .6-4.1 1.3-6.1 1.6-1.7.2-4.1.4-5.6-.4-1.1-.6-1.3-2.3-2.1-3.2-.4-.4-.6-.5-.8-1.2-.1-.1-.3-1.6-.2-1.6zm59.1 20.1c2.3-2 3.3-5.1 3.6-8.1.3-3 0-6.1.3-9.1.4-5.8 2.1-13.9 4.8-19.1 4.5-9.2-5.5 6.6-7.4 10.9-3.6 7.9-4.2 17.2-1.3 25.4zm-32.4-9.1c-4.4 3.9-8.8 8-14.3 10.3-5.4 2.3-12 2.6-16.9-.7 10.6-.4 22.1-4 31.2-9.6z'/><path class='lnng' d='M305.2 488c7.3 2.3 15.9-.6 20.4-6.8-3 2.4-6.8 2.3-10.6 2.8s-7.1 1.3-9.8 4zM442 409.3c-7.4 2.2-13.7 6-18.9 9.1.3-1.3.8-2.6 1.5-3.8.7-1.2 2.7-2.3 1.3-3.4-1.5-1.2-6.9-.2-12.6-.1 1.8-1 3.3-2.6 5.1-3.6-2-.8-8.1 3.2-12.5 3.4-4.4.2-8.7-.1-13.1.5-4.1.6-8 1.9-12 2.8-4 .9-8.3 1.2-12.1-.3 3.8 2.6 8.4 3.2 13 2.7s9.1-1.9 13.7-2.6c6.1-.8 12.3-.3 18.5.3-6.4 2.6-12.6 6.3-17.7 11 6.5-3.6 23.7-10.9 20.7-8.2-4.8 3.6-9.1 7.7-13.2 12.1 11-5.5 18.5-7.5 20.8-8.9 2.9-1.8 5.4-4.4 8.4-6.1 3.5-1.9 3.1 2.8 9.1-4.9z'/></g>,<path class='mtt' d='M0 0h800v1200H0z'/>,<path class='shdw' d='M526.7 515.9c-.3-7-.8-13.9-1.6-20.9-.8-6.4-1.3-13.4-3.5-19.3-3.5-9.9-6.9-19.5-12.2-28.6-6.4-11-15.1-20.3-25.4-27.2 0 0 0 .1-.1.1 2-3.8 2.8-8.2 3-14.1.1-3.4-.3-6.8-1-10.1 1.5-6.1 2.7-12.3 1.5-18.4-.9-4.6-3.9-8.5-5.5-12.8-.1-.3-.2-.7-.3-1-1-4.7.7-10.4-.5-15-.6-2.4-1.9-4.5-3.3-6.5-4.9-7.2-2.6-13-7.2-15-.1.2-.1.4-.2.6-1.3-2.2-2.6-4.4-3.7-6.7-2-5.7-3.8-12.2-2.8-18.2.8-4.7 3.5-9.1 4.1-13.8 1-2 1.8-4 2.3-6.2 1-4.3.6-8.7-.2-13.1-1.5-8.9-2.4-16.3-2.4-23.8s-.5-15.4-3.9-22c-1.9-3.7-4.7-7.2-7.5-10.1-.3.9-.7 1.6-.7 2.5 0 .6.1 1.2.2 1.7-8.6 2.4-15.5 8.8-22.1 15.3-1.9 1.4-3.6 3.7-4.9 5v.1c-1.7 1.9-3.2 3.9-4.3 6.2-1.5 3.1-2.2 6.6-3.4 9.9-.9 2.4-2.1 4.7-3.5 6.9-.1-.1-.1-.3-.2-.4-1.7.6-2.9 2.2-3.5 3.9-.3.9-.5 1.8-.6 2.7-.7 1-1.5 1.9-2.2 2.9-1-9.1-4.3-18.6-11.1-23.9-1.2-1.5-3.1-2.6-4.7-3.1-1.1-.3-2.3-.5-3.4-.9-1.6-.7-2-2.6-3.3-3.1-1.1-2.3-2-4.9-2.6-6.7-.9-3.1-2.6-6.4-5.5-7.2-1.1-.3-2.3-.3-3.3-.7-1.6-.8-2.5-2.7-3.6-4.2-1.4-1.8-3.1-3-5.1-3.8-.1-.2-.2-.4-.4-.5-.3-.3-.6-.4-1-.6-2.4-1.1-4.8-2-6.7-4-1.4-1.5-2.4-3.3-3.9-4.7-1-.9-3.1-2.2-4.5-1.6-2 .9-1 1.8-.5 3.6.3 1-.3 2.1-1.1 2.8-.8.6-1.8 1-2.6 1.5-2.9 1.8-4.3 5.9-3.4 9.2-.5 2-.7 4.2-1.4 6.2-1.1 3.5-3.7 6.2-5.6 9.3-2 3-3.3 7.3-2 10.8-.9 5.3-1.3 11.2 1 16.3.3.6.6 1.2.9 1.9.1.5.3 1 .5 1.6.4 1 .5 2.3.4 3.5-.1 2-.5 4-.7 6l-.3 1.8c-.6 4.1-1.2 8.2-1.3 12.4-.1 2.1.1 4.3.6 6.3-1 5.6.2 12 4.4 15.9 1.9 1.8 4 3.3 5.3 5.6 1.4 2.5 1.9 5.8 2.3 8.6.4 2.4 1 4.8 1.8 7.1.9 2.4 2 4.6 3 6.9.1.2.2.4.3.5h.1c.6 1.1 1.3 2.2 2.1 3 2.3 2.4 4.9 4.2 6.9 7.2 3.4 5.1 4 12.1 7.9 16.7-.1 0-.2-.1-.2-.1l-.1-.1c-1.2-.8-1.3-.7-1.9-.8-.6-.3-1.2-.5-1.8-.7-.1-.1-.3-.1-.4-.2v.1c-1.1-.4-2.3-.8-3.4-1.1-.9-.8-1.9-1.6-2.9-2.3-4.9-3.3-16.4-1.6-22.1-1.7h-.2c-3.3-.6-6.5-1.1-9.8-1.4-6-.6-12.2-.7-17.9 1.5-6.1 2.4-10.9 7.3-16.6 10.6-2.3 1.3-4.6 2.3-7.1 3.3-5.9.5-11.9 4.3-16.4 7.7-.5.4-1.1.8-1.5 1.3-10.9 9.3-15.2 25.4-19.7 39.9-2.8 8.9-7.2 18.7-15.2 21.7-.9 0-1.8-.1-2.7-.2-1.6 4.5 15 6.1 22 1.7 3.3-2.1 6.5-5.3 10.3-5.4 4.3 0 10.3 5.4 14.7 5.7 3.7 1 7.6 1 11.4.9 4.6-.2 9.2-.7 13.8-1.3 7.8-.8 9.9.1 13.5-2.6 4.2-.9 8.4-1.8 12.7-2.1 11.6-.7 23.8 3.6 35.2 2.6-3.6.8-7.1 1.7-10 3.5-2.6 1.5-5.2 3.1-7.9 4.5-2.8 1.5-6.3 2.3-8.9 4-2.6 1.7-4.8 4.2-7 6.7-.2.1-.3.2-.5.3-2.1 1.2-4.2 2.6-6.1 4.1-2.9 2.3-5.9 2.8-9.2 4-5.5 2.1-9.8 6.6-11.8 13.9-.3.9-.6 1.9-.9 2.8-1.2 4.3-1.8 9-4.1 12.8-1.7 2.8-4.3 5.3-4.4 8.7-.1 2.6 1.3 5.1 1.4 7.7.1 3.5-2.3 6.5-3.2 9.9-1.4 5.2.7 10.7 1.7 16 1.4 7.1.9 14.6-1.5 21.4 2.9-.8 5.7-1.4 8.4-2.6-.1.1-.2.1-.2.2 7.2.9 14.4-2.2 20.4-6.1 2.7-1.8 5.2-4.4 8.1-5.7 4.7-2.1 9.3-1.3 13.1-5.5 2.1-2.3 4-5 6.7-6.3 1.2-.5 2.5-.8 3.7-1.4 2.1-1.1 4.5-4.9 4.5-6.3.8-1 1.6-2.1 2.2-3.3 1.2-2.4 2.2-4.4 4.7-5.5 4.4-2 5-5.4 7.5-9.4.5-.8 1.1-1.5 1.7-2.2 3.3-.6 4.7-2.4 7-5.5l1.2-.9c2.7-2.2 5-4.8 6.9-7.8 2.3-1.5 3.8-4.1 5.3-6.6-.5 1.9-.7 3.7-.8 5.7-.1 2 .2 4 1.2 5.6l.1-.1c1.2 1.9 4 2.5 4.7 4.7.2.5.2 1.1.4 1.6.3.9 1.2 1.4 2.1 1.6 3.4.6 5.3.1 6.4 3.6-.4 2.9-1.1 5.8-2 8.6l-.3.3c1.8 1.9 4.7 2 7.2 1.4 2-.5 3.8-1.3 5.8-1.9 1.5-.3 3.1-.6 3.1-.6v-.1c2.8-.3 5.7.2 8.4 1 1.7 1.4 3.2 1.4 4.6 1.4 1.8.6 3.6 1.2 5 2.5s2.3 3 3.5 4.5c2.4 2.9 5.8 4.4 9.4 5.4 1.8.5 3.5 1.6 5.1 2.6 1.5.9 3.3 1.7 5 1.3.3-.1.5-.5.3-.7-.9-1.1-.7-3.1 0-4.4.9-1.5 2.3-2.5 3.5-3.8 2.9-3.1 3.2-7.8 3.4-12.2.4-16.7-1.2-21.7-3-27.5-1-3.2-2.3-6.4-2.8-9.7-.2-1.8-.9-7.3 1.1-7.9.8-.2 1.8-.2 2.4-.8.5-.5.6-1.4.5-2.1-.2-1.2-1-1.8-.8-2.8 1.1-.9 2.3-1.2 3.6-1.9 1.3-.8 2.6-1.8 3.6-2.9 2.4-2.5 3.8-5.8 4.9-9 .3-1 .3-2.1.5-3.2.4-2.7 1.4-5.4 2-8.1.6-2.7 1-5.5.9-8.3 0-.8-.3-2.7-.5-4.2.1 0 .3.1.4.1 1.9 1 3.5 4.3 5.2 5.6 3.8 2.8 7.2 6 9.8 10 5.8 8.9 9.9 18.1 13.6 28.2 1.1 3 1.8 6 2.3 9 .2 1.1.5 2.2.7 3.2 0 .1 0 .2.1.3.2 1 .5 2 .7 3-.1 10.2.5 20.4 0 30.7-.9 17.1-.7 33.8-3.3 50.7-1.3 8-3.8 15.8-5.4 23.7-.9 4.6-.8 9.3-1.8 13.9-1.5 7.5-4.6 14.4-7.5 21.4-2.2 5.2-4.1 10.3-5.8 15.7-1.6 5-3.5 9.9-5.8 14.6-3.2 6.5-7.1 12.5-9.7 19.3-2.1 5.4-5.5 10.5-8.3 15.6-3 5.5-6 10.9-9 16.4-1.7 3.1-3.4 6.1-4.9 9.3l-.6 1.5c-.7 2.3-2.1 5.9-3.1 8-10 21.6-17.8 44.2-27.2 66-6.4 14.8-12.1 29.8-17 45.2-1.9 6-3.8 11.9-5.8 17.9-.5 1.7-2 4-3.1 5.4-.1.1-.1.2-.2.3-.4.8-.5 1.8-.5 2.8-5.9-5.6-9.1-14.4-12.6-22.2-8-17.4-20.3-27.1-31.7-41.2-9.3-11.6-11.5-30.6-18.4-44.1-9-17.8-23.7-31.7-32.5-49.5-8.4-17-8.6-64.1-10.6-78.3 0 0 0-.1.1-.1.4-.9 1.8-3.3 3.1-5.8.1-.3.3-.5.4-.8 1.3-2.5 2.3-5 2.3-5.9-.1-1-1.6 0-5.9 4.8-5.2 5.2-8.9 11.2-11.4 17.9-.3.7-.5 1.5-.8 2.2-.3 1-.7 2-.9 3-1.2 4-2 8.3-2.5 12.6l-.3 2.4c-2.5 28.1 6.5 61.2 11.6 85.4 1 4.8 2 9.6 3 14.5.2 1.2.5 2.4.7 3.7.5 2.4 1 4.9 1.5 7.4s1 4.9 1.5 7.4c1.8 8.6 3.8 17.3 6 25.8 1.3 4.9 2.6 9.7 4.1 14.5.7 2.4 1.5 4.7 2.3 7.1.4 1.2.8 2.3 1.2 3.5.8 2.3 1.7 4.6 2.6 6.9.5 1.1.9 2.3 1.4 3.4.9 2.3 1.9 4.5 3 6.7 2.1 4.4 4.3 8.7 6.7 12.9 25.3 43.6 60.8 116.8 71.2 127.8l-.3-.6c1.5 2.2 3.3 4.2 5.3 5.7.1 4.3.1 8.6-.1 12.9-.6 15.8-.8 31.6.4 47.4.3 3.4.8 7.2 3.4 9.1 2.6 1.9 6.5 1.3 8.6 3.7.5.6.9 1.4 1.4 2.1.5.7 1.3 1.2 2.1 1 .7-.1 1.1-.7 1.5-1.3 2.1-3.1 2.7-7 2.6-10.7-.1-3.8-.9-7.5-1.5-11.2-.7-4.9-1.1-9.8-1.2-14.7-.2-6.1-2.1-11.9-1.2-18 .9-6.2.3-13.1.2-19.5 3.8-1.9 7.1-5 9.4-8.7 4.8-7.9 5.6-17.7 5.6-27.1-.2-26 .2-60-14.5-78.9 1-7.4 2.3-14.6 4.2-21.8 3.3-13.1 7.9-25.7 12.7-38.2 1.2-3.2 2.5-6.5 3.7-9.7 4.3-11.1 7.9-22.4 11.3-33.8 3.4-11.4 10.4-21.7 15-32.7 2.4-5.8 4.3-11.8 7.1-17.4.2-.3.3-.6.5-1 .9-1.8 1.9-3.5 3.1-5.1 3.7-5.3 6.6-11.3 9.1-17.4 2.8-6.8 10-20.1 10-20.2 0-1 2.3-3.5 2.9-4.4 1-1.7 2-3.5 2.9-5.3.2-.5.5-1 .7-1.5.1-.2.1-.3.2-.5.1-.4.3-.7.4-1.1.1-.2.1-.4.2-.5.1-.4.3-.7.4-1.1.1-.2.1-.3.2-.5.2-.5.3-.9.5-1.4.2-.6.4-1.1.6-1.7.1-.2.1-.3.2-.5.2-.6.5-1.2.7-1.8.1-.3.3-.6.4-.9 1.5-2.9 3.8-6.4 5.9-9.2l.1-.1c.3-.4.5-.7.8-1 .9-1.1 1.8-2.2 2.7-3.4.4-.5.7-.8.6-.7 0-.1 0-.2.1-.3.2-.4.5-.7.7-1.1l.1-.1c.2-.4.4-.8.6-1.3.6-1.3 1.1-2.6 1.5-4 .7-2.3 1.1-4.7 1.3-7 .4-4.1 1.7-8.2 2.8-12.2 1.5-5.6 3.1-11.2 4.4-16.8.4-1.9.2-3.7.3-5.6.3-3 .9-5.9 1.3-8.9 1.6-11.6 2.8-23.3 3.9-34.9.7-8.6 1.2-17.2 1.3-25.8-.6-6.1-.7-11.3-.9-16.4z'/>,<path class='stm' d='M452.5 934.7c-.3-32.8.4-77.9-29.2-92.1-10.1-4.8-14.4-16.5-19.3-26.6-8.8-18.1-22.5-28.1-35.1-42.8-10.3-12.1-12.8-31.8-20.3-45.8-9.9-18.4-26.2-32.8-36-51.3-9.3-17.6-9.5-66.5-11.8-81.2l.1-.1c1.5-2.8 13.6-22.5-.2-7.9-32.1 30-13.3 89.9-4.8 128.2 8.9 39.7 16.4 83.3 37.8 117.9 28 45.2 67.3 121.2 78.8 132.6-.1-.2-.2-.4-.4-.6 2.4 3.3 5.3 6.2 9.2 7.7 9 3.6 19.7-1.7 25-9.9 5.3-8.2 6.3-18.4 6.2-28.1zM299.8 596.9s0-.1 0 0c0-.1 0 0 0 0zm-1 2.2c0-.1.1-.2.1-.3 0 .2-.1.3-.1.3zm.3-.7c0-.1.1-.2.1-.2-.1 0-.1.1-.1.2zm.3-.8c0-.1.1-.1.1-.2 0 .1-.1.2-.1.2zm-.7 2.1c0 .1 0 .2-.1.2 0-.1.1-.1.1-.2zm106.5 338.5c.8 5.7-4.1 7.7 7 26.7-11.1-19-6.3-21.1-7-26.7zm-.8-2.9c.1.3.2.5.3.8-.1-.2-.2-.5-.3-.8zm.3.9c.1.2.1.4.2.6-.1-.2-.1-.4-.2-.6zm.2.8c0 .2.1.4.1.5 0-.2 0-.4-.1-.5zm.2.6c0 .2.1.3.1.5-.1-.2-.1-.3-.1-.5z'/><path class='shdw' d='M452.5 934.7c-.3-32.8.4-77.9-29.2-92.1-10.1-4.8-14.4-16.5-19.3-26.6-8.8-18.1-22.5-28.1-35.1-42.8-10.3-12.1-12.8-31.8-20.3-45.8-9.9-18.4-26.2-32.8-36-51.3-9.3-17.6-9.5-66.5-11.8-81.2-1 1.9-2.2 3.7-2.3 5.9 0 1.3.3 2.5.3 3.8 0 2.3-1.8 3-3.3 4.2-2.1 1.7-2.5 3.1-3.2 5.8-1.5 5.4-2.3 11-2.4 16.6-.2 10.5 1.9 21.7 6.6 31.2 5 10.2 7.7 22.6 8.2 33.9.2 5.5-1 10.8-1.3 16.2-.4 8.9 3.5 19.3 9.4 26 5.4 6.1 11.9 11.2 16.6 17.8 4 5.7 6.5 12.4 9.8 18.5 3.3 6.1 8.3 10.5 12.3 16.2 7.4 10.6 8.7 25.4 7 38-1.3 9.4-3.9 17.5-1.1 27 1.8 6 4.1 13.1 9.4 14.5 9.5 2.6 15.2 10.2 20.5 16.2 6.7 7.7 9.5 16.1 9.8 26.3.5 15.6 3.7 13.5 7.3 22.4 3.3 8.2-4.9 7.7 7.8 29.5 2.4 3.3 5.3 6.2 9.2 7.7 9 3.6 19.7-1.7 25-9.9 5.2-8.1 6.2-18.3 6.1-28z'/><path class='stm' d='M563.7 472.6c-.3-7.2-.9-14.5-1.8-21.6-.8-6.6-1.4-13.9-3.8-20.1-3.9-10.3-7.7-20.2-13.5-29.6-7.1-11.4-16.7-21-28.1-28.2-3 3.7-6.3 6.7-9.3 10.3-.8 1-.4 1.7.8 1.6 1.9-.1 3.8-.7 5.5 0 2.1 1 3.9 4.5 5.8 5.8 4.2 2.9 8 6.2 10.9 10.4 6.4 9.3 10.9 18.8 15 29.2 1.2 3.1 2 6.2 2.6 9.3.5 2.3 1.1 4.5 1.7 6.7-.1 10.6.6 21.2 0 31.9-1 17.7-.8 35-3.7 52.6-1.4 8.3-4.2 16.4-6 24.5-1 4.7-.9 9.7-2 14.4-1.7 7.7-5.1 14.9-8.3 22.1-2.4 5.4-4.5 10.7-6.4 16.3-1.7 5.2-3.9 10.3-6.4 15.2-3.6 6.8-7.8 12.9-10.7 20.1-2.3 5.6-6 10.9-9.1 16.2-3.3 5.7-6.6 11.3-10 17-1.9 3.2-3.7 6.3-5.4 9.6-.3.5-.5 1-.6 1.6-.8 2.3-2.3 6.1-3.4 8.3-11 22.4-19.7 45.8-30.1 68.5-7 15.3-13.4 31-18.9 46.9-2.1 6.2-4.2 12.4-6.4 18.6-.6 1.7-2.3 4.2-3.4 5.6-.1.1-.1.2-.2.3-1.1 2-.1 5.7-.1 7.8.4 12.4.4 24.7-.1 37.1-.5 13-1.3 26.1-1.7 39.1-.7 21.4 2.1 42.8 1.3 64.2-.6 16.4-.9 32.8.5 49.2.3 3.5.9 7.5 3.7 9.4 2.9 2 7.2 1.3 9.5 3.9.6.7 1 1.5 1.6 2.2.6.7 1.5 1.2 2.3 1.1.7-.1 1.3-.7 1.7-1.3 2.3-3.2 3-7.2 2.9-11.1s-1-7.7-1.7-11.6c-.8-5.1-1.2-10.2-1.3-15.3-.2-6.3-2.3-12.3-1.3-18.6 1.1-6.9.1-14.8.1-21.8v-26c0-5.2-1-10.3-1.7-15.4-1.3-9.2-1-18.6-.9-27.9.1-10.1.5-20.2 1.1-30.3.9-13.7 2.8-27.2 6.4-40.4 3.7-13.5 8.7-26.7 14-39.7 1.4-3.4 2.7-6.7 4.1-10.1 4.7-11.5 8.7-23.2 12.5-35.1 3.8-11.9 11.6-22.5 16.6-33.9 2.6-6 4.8-12.3 7.9-18 .2-.3.4-.7.5-1 1-1.8 2.1-3.6 3.4-5.3 4.1-5.5 7.3-11.7 10.1-18 3.1-7.1 11-20.8 11-20.9 0-1 2.6-3.6 3.2-4.6 1.1-1.8 2.2-3.6 3.2-5.5 1.2-2.2 2-4.6 2.9-6.9.5-1.4 1.1-2.8 1.7-4.1.2-.3.3-.7.5-1 1.6-3 4.2-6.6 6.5-9.5l.1-.1c1.3-1.6 2.6-3.1 3.9-4.6.5-.6.8-.8.7-.8 0-.1 0-.2.1-.3.6-.8 1.1-1.7 1.6-2.6 1.7-3.5 2.7-7.6 3.1-11.5.4-4.3 1.9-8.5 3.1-12.6 1.6-5.8 3.4-11.6 4.8-17.5.5-2 .2-3.8.4-5.8.3-3.1.9-6.2 1.4-9.2 1.7-12 3.1-24.1 4.3-36.2 1.4-14.4 1.9-28.7 1.3-43z'/><path class='shdw' d='M563.7 472.6c-.3-7.2-.9-14.5-1.8-21.6-.8-6.6-1.4-13.9-3.8-20.1-3.9-10.3-7.7-20.2-13.5-29.6-7.1-11.4-16.7-21-28.1-28.2-3 3.7-6.3 6.7-9.3 10.3-.8 1-.4 1.7.8 1.6 1.9-.1 3.8-.7 5.5 0 2.1 1 3.9 4.5 5.8 5.8 4.2 2.9 8 6.2 10.9 10.4 6.4 9.3 10.9 18.8 15 29.2 1.2 3.1 2 6.2 2.6 9.3 3.5 14.7 7.7 24 6.2 50.9-1 18.5 2.3 26.2 1.3 44.7 0 5.3-1.2 16.2-1.8 21.4-.6 5.4-2.7 11-4.1 16.3-1.6 6-3.2 12-3.5 18.2-.2 3.8-.5 6.1-2.3 9.4-4.1 7.5-9.5 14.2-14 21.3-4.3 6.8-6.4 14.8-9.6 22.2-6.8 15.4-15.1 30.1-22.6 45.2-1.2 2.4-2.2 5.9-3.9 7.9 2.6-3.1 3.8-7.1 6.5-10.2 4.1-5.5 7.3-11.7 10.1-18 3.1-7.1 11-20.8 11-20.9 0-1 2.6-3.6 3.2-4.6 1.1-1.8 2.2-3.6 3.2-5.5 1.8-3.5 2.9-7.4 4.6-11 1.8-3.8 4.5-7.3 7.1-10.6 2.2-2.8 4.7-5.1 6.2-8.3 1.7-3.5 2.7-7.6 3.1-11.5.4-4.3 1.9-8.5 3.1-12.6 1.6-5.8 3.4-11.6 4.8-17.5.5-2 .2-3.8.4-5.8.3-3.1.9-6.2 1.4-9.2 1.7-12 3.1-24.1 4.3-36.2 1.3-14.1 1.8-28.4 1.2-42.7z'/>]"