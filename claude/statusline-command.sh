#!/usr/bin/env bash
# Claude Code status line — shows model name and tokens/second throughput
# Receives JSON on stdin with fields like context_window.total_output_tokens,
# cost.total_api_duration_ms, model.display_name, etc.

input=$(cat)

model=$(echo "$input" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('model',{}).get('display_name',''))" 2>/dev/null)
out_tokens=$(echo "$input" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('context_window',{}).get('total_output_tokens',0))" 2>/dev/null)
api_ms=$(echo "$input" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('cost',{}).get('total_api_duration_ms',0))" 2>/dev/null)
cost=$(echo "$input" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('cost',{}).get('total_cost',''))" 2>/dev/null)

parts=""

if [ -n "$model" ]; then
  parts="$model"
fi

if [ -n "$out_tokens" ] && [ "$out_tokens" != "0" ] && [ -n "$api_ms" ] && [ "$api_ms" != "0" ]; then
  tps=$(python3 -c "print(round($out_tokens * 1000 / $api_ms, 1))" 2>/dev/null)
  if [ -n "$tps" ]; then
    parts="$parts | ${tps} tok/s"
  fi
fi

if [ -n "$cost" ] && [ "$cost" != "0" ] && [ "$cost" != "" ]; then
  parts="$parts | \$$cost"
fi

echo "$parts"