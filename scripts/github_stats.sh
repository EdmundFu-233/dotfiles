#!/usr/bin/env bash
# github_stats.sh — Quick GitHub activity stats for a user
#
# Usage:
#   ./github_stats.sh EdmundFu-233              # last 30 days summary
#   ./github_stats.sh EdmundFu-233 --days 90     # custom range
#   ./github_stats.sh EdmundFu-233 --repos       # show repo stats only
#
# Requires: curl, jq

set -euo pipefail

USERNAME="${1:-}"
DAYS="${2:-30}"
MODE="${3:-full}"

# Parse --days and --repos flags
for arg in "$@"; do
  case "$arg" in
    --days)    DAYS="${2:-30}"; shift ;;
    --repos)   MODE="repos" ;;
  esac
done

if [[ -z "$USERNAME" ]]; then
  echo "Usage: $0 <github-username> [--days N] [--repos]"
  exit 1
fi

SINCE=$(date -d "$DAYS days ago" --utc +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || date -v-${DAYS}d -u +%Y-%m-%dT%H:%M:%SZ)

echo "🔍 GitHub Stats for @$USERNAME (last $DAYS days)"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# --- Events API (public, no auth needed) ---
EVENTS_URL="https://api.github.com/users/$USERNAME/events?per_page=100"
EVENTS=$(curl -sf "$EVENTS_URL" 2>/dev/null || echo "[]")

if [[ "$EVENTS" == "[]" ]]; then
  echo "No public events found (or rate-limited)."
  exit 0
fi

# Count event types
echo ""
echo "📊 Activity Breakdown:"
echo "$EVENTS" | jq -r '
  [.[] | select(.created_at >= "'"$SINCE"'")]
  | group_by(.type)
  | map({type: .[0].type, count: length})
  | sort_by(-.count)
  | .[]
  | "  \(.type): \(.count)"
' 2>/dev/null

# Count by repo
echo ""
echo "📂 Top Repositories:"
echo "$EVENTS" | jq -r '
  [.[] | select(.created_at >= "'"$SINCE"'")]
  | group_by(.repo.name)
  | map({repo: .[0].repo.name, count: length})
  | sort_by(-.count)
  | .[:10]
  | .[]
  | "  \(.repo): \(.count) events"
' 2>/dev/null

# Commit count
COMMIT_COUNT=$(echo "$EVENTS" | jq '[.[] | select(.created_at >= "'"$SINCE"'" and .type == "PushEvent") | .payload.commits | length] | add' 2>/dev/null || echo "0")
echo ""
echo "📝 Total commits pushed: $COMMIT_COUNT"

# Active days
ACTIVE_DAYS=$(echo "$EVENTS" | jq -r '([.[] | select(.created_at >= "'"$SINCE"'") | .created_at[:10]] | unique | length)' 2>/dev/null || echo "0")
echo "📅 Active days: $ACTIVE_DAYS / $DAYS"

# Streak calculation
STREAK=0
TODAY=$(date -u +%Y-%m-%d)
for ((i=0; i<DAYS; i++)); do
  CHECK_DATE=$(date -d "$i days ago" --utc +%Y-%m-%d 2>/dev/null || date -v-${i}d -u +%Y-%m-%d)
  HAS_EVENT=$(echo "$EVENTS" | jq -r --arg d "$CHECK_DATE" 'any(.[]; .created_at[:10] == $d)' 2>/dev/null)
  if [[ "$HAS_EVENT" == "true" ]]; then
    ((STREAK++))
  else
    break
  fi
done
echo "🔥 Current streak: $STREAK day(s)"

if [[ "$MODE" == "repos" ]]; then
  echo ""
  echo "📦 Repository Details:"
  echo "$EVENTS" | jq -r '
    [.[] | select(.created_at >= "'"$SINCE"'")]
    | group_by(.repo.name)
    | map({
        repo: .[0].repo.name,
        pushes: [.[] | select(.type == "PushEvent")] | length,
        prs: [.[] | select(.type == "PullRequestEvent")] | length,
        issues: [.[] | select(.type == "IssuesEvent")] | length,
        last_active: (max_by(.created_at) | .created_at[:16])
      })
    | sort_by(-.pushes)
    | .[]
    | "  \(.repo)\n    pushes=\(.pushes)  prs=\(.prs)  issues=\(.issues)  last=\(.last_active)"
  ' 2>/dev/null
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "Data from GitHub Events API (public events only)"
