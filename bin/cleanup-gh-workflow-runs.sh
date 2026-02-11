#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <owner> <repo> <workflow-name>"
  exit 1
fi

OWNER="$1"
REPO="$2"
WF_NAME="$3"

echo "🔍 Fetching workflow ID for: $WF_NAME"

WF_ID=$(gh api \
  "repos/${OWNER}/${REPO}/actions/workflows" \
  --jq ".workflows[] | select(.name == \"${WF_NAME}\") | .id")

if [[ -z "$WF_ID" ]]; then
  echo "❌ Workflow not found: $WF_NAME"
  exit 1
fi

echo "✔ Workflow ID: $WF_ID"
echo "🔍 Fetching workflow runs..."

RUN_IDS=$(gh api \
  "repos/${OWNER}/${REPO}/actions/runs" \
  --paginate \
  --jq ".workflow_runs[] | select(.workflow_id == ${WF_ID}) | .id")

if [[ -z "$RUN_IDS" ]]; then
  echo "✔ No runs found for workflow: $WF_NAME"
  exit 0
fi

echo "⚠ Found $(echo "$RUN_IDS" | wc -l) runs for workflow '$WF_NAME'"
read -p "Delete ALL runs? (y/N): " CONFIRM

if [[ "$CONFIRM" != "y" ]]; then
  echo "Cancelled."
  exit 0
fi

echo "🗑 Deleting runs..."

for RUN_ID in $RUN_IDS; do
  gh api -X DELETE "repos/${OWNER}/${REPO}/actions/runs/${RUN_ID}" >/dev/null
  echo "Deleted run: $RUN_ID"
done

echo "🎉 Done. All runs deleted for workflow: $WF_NAME"
