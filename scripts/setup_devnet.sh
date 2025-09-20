#!/bin/bash
curl -fsSL https://get.sui.io | sh
sui client new-address ed25519
sui client switch --env devnet