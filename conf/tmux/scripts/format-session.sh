#!/bin/sh
session=$(tmux display-message -p '#S' 2>/dev/null)

if echo "$session" | grep -q '/'; then
  project="${session##*/}"
  branch="${session%%/*}"
  ticket=$(echo "$branch" | grep -oE '[a-zA-Z]+-[0-9]+' | head -1)
  if [ -n "$ticket" ] && [ -n "$project" ]; then
    ticket_upper=$(echo "$ticket" | tr '[:lower:]' '[:upper:]')
    echo "$project | $ticket_upper"
  else
    echo "$session"
  fi
else
  echo "$session"
fi
