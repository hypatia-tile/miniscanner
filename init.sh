#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <project-name>"
  exit 1
fi

project_name=$1

cabal init --non-interactive \
  --package-name="$project_name" \
  --license=BSD-3-Clause \
  --libandexe \
  --tests \
  --main-is=Main.hs \
  --language=GHC2021
