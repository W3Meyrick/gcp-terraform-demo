#!/bin/sh

set -e

WORKING_DIR=$(pwd)
WORKSPACE_DIR="$WORKING_DIR/workspace"
mkdir -p "$WORKING_DIR/artifacts"
ARTIFACTS_DIR="$WORKING_DIR/artifacts"
LAYERS_DIR="$WORKING_DIR/layers"
GCS_BUCKET="w3-terraform-state"

if [ -f "$WORKSPACE_DIR/changed_layers" ]; then
  LAYERS=$(cat "$WORKSPACE_DIR/changed_layers" | sort -nr)
else
  LAYERS=$(find "$LAYERS_DIR"/* -maxdepth 0 -type d -exec basename '{}' \; | sort -nr)
fi

for LAYER in $LAYERS; do
  echo "terraform init $LAYER"
  (cd "$LAYERS_DIR/$LAYER" && terraform init -input=false -no-color)

  # Create artifacts sub-directory for the layer 
  if [ ! -d "$ARTIFACTS_DIR/$LAYER" ]; then
    mkdir "$ARTIFACTS_DIR/$LAYER"
  fi  

  # cache .terraform during the plan
  (cd "$LAYERS_DIR/$LAYER" && tar -czf "$ARTIFACTS_DIR/$LAYER/.terraform.$LAYER.$(git rev-parse --short HEAD).tar.gz" .terraform)

  echo "terraform plan $LAYER"
  (cd "$LAYERS_DIR/$LAYER" && terraform plan -no-color -input=false -out="$ARTIFACTS_DIR/$LAYER/terraform.$LAYER.$(git rev-parse --short HEAD).plan" | tee "$LAYERS_DIR/full_plan_output.log" | grep -v "Refreshing state" )

  gsutil rm gs://$GCS_BUCKET/artifacts/$LAYER/** || true

  # Copy archive to GCS
  gsutil cp $ARTIFACTS_DIR/$LAYER/.terraform.$LAYER.$(git rev-parse --short HEAD).tar.gz gs://$GCS_BUCKET/artifacts/$LAYER/

  # Copy plan to GCS
  gsutil cp $ARTIFACTS_DIR/$LAYER/terraform.$LAYER.$(git rev-parse --short HEAD).plan gs://$GCS_BUCKET/artifacts/$LAYER/

  # for debugging show these files exist
  echo "The following artifacts have been stored"
  ls -la "$ARTIFACTS_DIR/$LAYER/.terraform.$LAYER.$(git rev-parse --short HEAD).tar.gz"
  ls -la "$ARTIFACTS_DIR/$LAYER/terraform.$LAYER.$(git rev-parse --short HEAD).plan"
done
