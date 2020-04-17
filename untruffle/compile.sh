#/bin/sh

CONTRACTS_BUILD_DIR=build/contracts
OUTPUT_DIR=untruffle/compiled

rm -r $OUTPUT_DIR
mkdir -p $OUTPUT_DIR
solc @openzeppelin=/Users/joeb/Workspace/rapid/cooganNFT/node_modules/@openzeppelin -o $OUTPUT_DIR --bin --abi --optimize contracts/*.sol 

mkdir -p $CONTRACTS_BUILD_DIR
