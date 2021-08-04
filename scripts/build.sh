#!/bin/bash

set -e

SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PROJECT_DIRECTORY="$SCRIPT_DIRECTORY/.."

cd "$PROJECT_DIRECTORY"

tsc --build --clean
tsc --build
sed -i '' '/exports,\.*__esModule/d' build/main.js
