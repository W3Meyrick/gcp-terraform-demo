#!/bin/sh

set -e

WORKING_DIR=$(pwd)
WORKSPACE_DIR="$WORKING_DIR/workspace"
LAYERS_DIR="$WORKING_DIR/layers"
LAYERS=$(find "$LAYERS_DIR"/* -maxdepth 0 -type d -exec basename '{}' \; | sort -n)

OVERALL_RETURN=0
for LAYER in $LAYERS; do
  echo "terraform fmt $LAYER"

  cd "$LAYERS_DIR/$LAYER" && terraform fmt -check=true -write=false -diff=false -list=true && terraform get
  LINT_RETURN=$?

  if [ $LINT_RETURN -ne 0 ]
  then
    echo "Linting failed in $LAYER please run terraform fmt"
    OVERALL_RETURN=1
  fi
done

for LAYER in $LAYERS; do
  echo "tflint $LAYER"

  LINT_OUTPUT=$(cd "$LAYERS_DIR/$LAYER" && tflint)
  LINT_RETURN=$?

  if [ $LINT_RETURN -ne 0 ]
  then
    echo "Linting failed in $LAYER, please run tflint and troubleshoot"
    echo $LINT_OUTPUT
    OVERALL_RETURN=1
  fi
done

if [ $OVERALL_RETURN -ne 0 ]
then
  exit $OVERALL_RETURN
fi
