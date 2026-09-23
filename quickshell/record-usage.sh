#!/usr/bin/env bash
# Increment the launch counter for a desktop entry id.
# Usage: record-usage.sh <app-id>
set -euo pipefail

app_id="${1:?app id required}"
state_dir="${XDG_STATE_HOME:-$HOME/.local/state}/ricky-menu"
usage_file="$state_dir/app-usage.json"

mkdir -p "$state_dir"
[[ -f $usage_file ]] || printf '{}\n' >"$usage_file"

tmp="$(mktemp "$state_dir/usage.XXXXXX")"
jq --arg id "$app_id" '.[$id] = ((.[$id] // 0) + 1)' "$usage_file" >"$tmp"
mv "$tmp" "$usage_file"
