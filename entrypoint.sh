#!/usr/bin/env bash
set -eo pipefail

echo "Configuring env variables..."
export CI=''

echo "Checking NodeJS Heap configuration..."
node -e 'console.log(`node heap limit = ${require("v8").getHeapStatistics().heap_size_limit / (1024 * 1024)} Mb`)'
#export NODE_OPTIONS="--max-old-space-size=8192"
#echo '\nLANG="en_US.UTF-8"' >> /etc/default/locale && /etc/environment

echo "Configuring RPC Connections" 
DEFAULT_RPC_URI='https://api.sushirelay.com/v1'

if [[ -n "${MANIFOLD_FINANCE_RPC_URI}" ]]; then
echo "Replacing default RPC URI value with '${MANIFOLD_FINANCE_RPC_URI}' ..."
find .next/static/chunks .next/server/chunks -type f -exec sed -i -e "s|${DEFAULT_RPC_URI}|${MANIFOLD_FINANCE_RPC_URI}|g" {} \;
fi


echo "Executing NextJS server..."
yarn start
