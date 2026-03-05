#!/usr/bin/env bash
set -euo pipefail

AUTO_CONFIRM=false
if [[ "$1" == "--yes" ]]; then
  AUTO_CONFIRM=true
  shift
fi

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 [--yes] <owner> <repo> <environment>"
  exit 1
fi

OWNER="$1"
REPO="$2"
ENV_NAME="$3"

echo "🔍 Fetching deployments for environment: $ENV_NAME"

DEPLOYMENT_IDS=$(gh api \
  "repos/${OWNER}/${REPO}/deployments" \
  --paginate \
  --jq ".[] | select(.environment == \"${ENV_NAME}\") | .id"
)

if [[ -z "$DEPLOYMENT_IDS" ]]; then
  echo "✔ No deployments found for environment: $ENV_NAME"
else
  COUNT=$(echo "$DEPLOYMENT_IDS" | wc -l | tr -d ' ')
  echo "⚠ Found ${COUNT} deployments in environment '$ENV_NAME'."

  if [[ "$AUTO_CONFIRM" != true ]]; then
    read -p "Delete ALL of them? (y/N): " CONFIRM
    if [[ "$CONFIRM" != "y" ]]; then
      echo "Cancelled."
      exit 0
    fi
  fi

  echo "🗑 Deleting deployments..."

  for DEPLOY_ID in $DEPLOYMENT_IDS; do
    # Github requires deployments to have no active statuses before deletion.
    # We’ll mark them as inactive first to ensure deletion works reliably.
    gh api \
      -X POST \
      "repos/${OWNER}/${REPO}/deployments/${DEPLOY_ID}/statuses" \
      -f state=inactive >/dev/null

    # Now delete the deployment
    gh api \
      -X DELETE \
      "repos/${OWNER}/${REPO}/deployments/${DEPLOY_ID}" >/dev/null

    echo "Deleted deployment: $DEPLOY_ID"
  done
fi

echo "🗑 Deleting environment..."

gh api \
  -X DELETE \
  "repos/${OWNER}/${REPO}/environments/${ENV_NAME}" > /dev/null

echo "🎉 Done. Deleted environment and all its deployments: $ENV_NAME"

