#!/bin/bash

LOGFILE=/tmp/worklock.log
exec >>"$LOGFILE" 2>&1

INTERVAL=$((45 * 60)) # 45 minutes
WARNING=60            # 1 minute warning

get_session_id() {
  loginctl show-user "$USER" -p Display --value
}

get_lock_state() {
  local session
  session="$(get_session_id)"
  loginctl show-session "$session" -p LockedHint --value
}

echo "Script started at $(date)"

# Wait for graphical session
while [ -z "$(get_session_id)" ]; do
  sleep 2
done

# Wait until unlocked
while [ "$(get_lock_state)" = "yes" ]; do
  sleep 2
done

while true; do
  echo "Timer started at $(date)"
  notify-send "WorkLock" "Focus session started (45 minutes)"

  # Sleep until 1-minute warning
  sleep $((INTERVAL - WARNING))

  notify-send -u critical "WorkLock" "1 minute left! Screen will lock soon"

  # Final 1 minute
  sleep "$WARNING"

  session="$(get_session_id)"
  echo "Locking session $session at $(date)"
  loginctl lock-session "$session"

  # Wait until lock engages
  while [ "$(get_lock_state)" != "yes" ]; do
    sleep 1
  done

  # Wait until user unlocks
  while [ "$(get_lock_state)" = "yes" ]; do
    sleep 2
  done
done
