#!/bin/bash

# Toggle a logind inhibitor so closing the lid does not suspend the machine.
# This keeps Wi-Fi and long-running agents alive without changing global logind config.

set -u

STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}"
PID_FILE="$STATE_DIR/hypr-lid-inhibit.pid"
WHAT="handle-lid-switch:sleep:idle"
WHO="Hyprland sys-menu"
WHY="hypr-lid-inhibit: keep Wi-Fi and active agents running while lid is closed"

notify() {
    if command -v notify-send >/dev/null 2>&1; then
        notify-send "$@" || true
    fi
}

read_pid() {
    local pid
    [ -r "$PID_FILE" ] || return 1
    read -r pid <"$PID_FILE" || return 1
    [[ "$pid" =~ ^[0-9]+$ ]] || return 1
    printf '%s\n' "$pid"
}

pid_is_inhibitor() {
    local pid="$1" comm cmdline
    [ -n "$pid" ] || return 1
    kill -0 "$pid" 2>/dev/null || return 1

    comm=$(cat "/proc/$pid/comm" 2>/dev/null) || return 1
    [ "$comm" = "systemd-inhibit" ] || return 1

    cmdline=$(tr '\0' ' ' <"/proc/$pid/cmdline" 2>/dev/null) || return 1
    [[ "$cmdline" == *"hypr-lid-inhibit:"* ]]
}

active_pid() {
    local pid found

    if pid=$(read_pid 2>/dev/null) && pid_is_inhibitor "$pid"; then
        printf '%s\n' "$pid"
        return 0
    fi

    rm -f "$PID_FILE"

    while IFS= read -r found; do
        if pid_is_inhibitor "$found"; then
            printf '%s\n' "$found"
            return 0
        fi
    done < <(pgrep -u "$(id -u)" -x systemd-inhibit || true)

    return 1
}

start_inhibitor() {
    local pid

    if active_pid >/dev/null; then
        notify "Lid Close" "Lid-close sleep is already off" -i dialog-information
        return 0
    fi

    if ! command -v systemd-inhibit >/dev/null 2>&1; then
        notify "Lid Close" "systemd-inhibit not found" -i dialog-error
        return 1
    fi

    systemd-inhibit --what="$WHAT" --who="$WHO" --why="$WHY" --mode=block sleep infinity >/dev/null 2>&1 &
    pid=$!
    disown "$pid" 2>/dev/null || true
    printf '%s\n' "$pid" >"$PID_FILE"

    sleep 0.2
    if pid_is_inhibitor "$pid"; then
        notify "Lid Close" "Lid-close sleep off; Wi-Fi and agents stay online" -i dialog-information
        return 0
    fi

    rm -f "$PID_FILE"
    notify "Lid Close" "Failed to disable lid-close sleep" -i dialog-error
    return 1
}

stop_inhibitor() {
    local pid

    if ! pid=$(active_pid); then
        notify "Lid Close" "Lid-close sleep is already on" -i dialog-information
        return 0
    fi

    kill -TERM "-$pid" 2>/dev/null || kill -TERM "$pid" 2>/dev/null || true
    rm -f "$PID_FILE"
    notify "Lid Close" "Lid-close sleep on; default suspend behavior restored" -i dialog-information
}

case "${1:-toggle}" in
    start|on|disable-sleep)
        start_inhibitor
        ;;
    stop|off|enable-sleep)
        stop_inhibitor
        ;;
    status)
        if active_pid >/dev/null; then
            echo "active"
        else
            echo "inactive"
        fi
        ;;
    toggle)
        if active_pid >/dev/null; then
            stop_inhibitor
        else
            start_inhibitor
        fi
        ;;
    *)
        echo "Usage: $0 [start|stop|toggle|status]" >&2
        exit 2
        ;;
esac
