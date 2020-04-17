#/bin/sh
################################################
## THIS SCRIPT WILL NOT WORK UNLESS CALLED
## USING `npm run compile`
################################################
COMPILE_DIR=$1
echo $1
if [ -z "$1" ]  
then
    echo "SETTING Default"
    COMPILE_DIR=contracts
fi

. .env

if [ -z "$SOLC_V5" ]  
then
    echo "no SOLC_V5 set"
    exit 1;
fi

echo "COMPILE DIR $COMPILE_DIR"
CONTRACTS_BUILD_DIR=build/contracts
OUTPUT_DIR=untruffle/compiled

NODE_MODULES_PATH=`pwd`/node_modules
echo "node DIR $NODE_MODULES_PATH"

rm -r $OUTPUT_DIR
mkdir -p $OUTPUT_DIR
$SOLC_V5 @openzeppelin=$NODE_MODULES_PATH/@openzeppelin -o $OUTPUT_DIR --bin --abi --optimize $COMPILE_DIR/*.sol --allow-paths *,

mkdir -p $CONTRACTS_BUILD_DIR
