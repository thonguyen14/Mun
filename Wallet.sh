#!/bin/bash
wallet="tunguyen"
(mund keys show wallet -a)="mun1vs6u4msngzmqtv88k7kjawqaa8ysq0ly4ndvjs"
(mund keys show wallet --bech val -a)="munvaloper1vs6u4msngzmqtv88k7kjawqaa8ysq0lykf55g3"
(mund keys list)=
"-name: tunguyen
  type: local
  address: mun1vs6u4msngzmqtv88k7kjawqaa8ysq0ly4ndvjs
  pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AgU4JH+/k9WzmnJgzftoKYAZJH6zT4R6bjTWQTj4l7OS"}'
  mnemonic: "" "
