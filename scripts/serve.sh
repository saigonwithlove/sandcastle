#!/bin/bash

set -e

SCRIPT_DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
PROJECT_DIRECTORY="$SCRIPT_DIRECTORY/.."
BASE_DIRECTORY="$SCRIPT_DIRECTORY/../build"

SANDBOX_CLI_REPOSITORY="https://github.com/getsandbox/worker-cli.git"
SANDBOX_DIRECTORY="$SCRIPT_DIRECTORY/../.cache/worker-cli"
SANDBOX_CLI="$SANDBOX_DIRECTORY/cli/build/libs/worker.cli-all.jar"

if [ ! -d "$SANDBOX_DIRECTORY" ]; then
  mkdir -p "$SANDBOX_DIRECTORY"
  git clone --depth 1 "$SANDBOX_CLI_REPOSITORY" "$SANDBOX_DIRECTORY"
fi

if [ ! -f "$SANDBOX_CLI" ]; then
  cd $SANDBOX_DIRECTORY
  ./gradlew clean shadowJar
fi

cd $PROJECT_DIRECTORY
npx nodemon --ext ts --watch src --exec "npx tsc --build --incremental && sed -i '' '/exports.*__esModule/d' build/main.js" &
java -Dapp.worker.port=8090 -jar "$SANDBOX_CLI" --base="$BASE_DIRECTORY" --metadataPort=8099 --port=8090
