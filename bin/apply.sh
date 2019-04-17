#!/bin/sh

set -e

WORKING_DIR=$(pwd)
WORKSPACE_DIR="$WORKING_DIR/workspace"
mkdir -p "$WORKING_DIR/artifacts"
GCS_BUCKET="w3-terraform-state"
ARTIFACTS_DIR="$WORKING_DIR/artifacts"
LAYERS_DIR="$WORKING_DIR/layers"

if [ -f "$WORKSPACE_DIR/changed_layers" ]; then
  LAYERS=$(cat "$WORKSPACE_DIR/changed_layers" | sort -nr)
else
  LAYERS=$(find "$LAYERS_DIR"/* -maxdepth 0 -type d -exec basename '{}' \; | sort -nr)
fi

for LAYER in $LAYERS; do
  # for debugging, show that these files exist
  ls -la "$ARTIFACTS_DIR/"

  echo "Copying plan file for $LAYER"
  gsutil cp gs://$GCS_BUCKET/artifacts/$LAYER/terraform.$LAYER.$(git rev-parse --short HEAD).plan $ARTIFACTS_DIR

  echo "terraform init  $LAYER"
  (cd "$LAYERS_DIR/$LAYER" && terraform init)

  echo "terraform apply $LAYER"
  (cd "$LAYERS_DIR/$LAYER" && terraform apply -input=false -no-color "$ARTIFACTS_DIR/terraform.$LAYER.$(git rev-parse --short HEAD).plan")

#  if [ -f "$LAYERS_DIR/$LAYER/gcp_hosts" ]; then
#  (cd "$LAYERS_DIR/$LAYER" && gsutil cp gcp_hosts gs://$GCS_BUCKET/artifacts/$LAYER/)
#  fi

done