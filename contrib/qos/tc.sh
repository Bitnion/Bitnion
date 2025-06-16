#!/usr/bin/env bash
#
# Bitnion QoS Emulator Script (tc.sh)
# Simulates network conditions (latency, bandwidth, packet loss)
# using Linux `tc` for testing Bitnion Core under limited connectivity.
#
# License: MIT

set -e

IFACE="$1"
DELAY="${2:-50ms}"
RATE="${3:-1mbit}"
LOSS="${4:-0.1%}"

show_help() {
    echo "Usage:"
    echo "  sudo ./tc.sh <interface> [delay] [rate] [loss]"
    echo ""
    echo "Examples:"
    echo "  sudo ./tc.sh eth0 100ms 2mbit 0.5%"
    echo "  sudo ./tc.sh eth0 clear"
}

if [[ -z "$IFACE" ]]; then
    echo "[!] Error: No interface specified."
    show_help
    exit 1
fi

if [[ "$2" == "clear" ]]; then
    echo "[*] Clearing existing traffic shaping rules on $IFACE..."
    tc qdisc del dev "$IFACE" root || true
    echo "[✓] Cleared."
    exit 0
fi

# Apply traffic control rules
echo "[*] Applying QoS settings on $IFACE:"
echo "    ➤ Delay: $DELAY"
echo "    ➤ Bandwidth: $RATE"
echo "    ➤ Packet Loss: $LOSS"

# Clean any existing root qdisc
tc qdisc del dev "$IFACE" root 2>/dev/null || true

# Add HTB for rate limiting
tc qdisc add dev "$IFACE" root handle 1: htb default 11
tc class add dev "$IFACE" parent 1: classid 1:1 htb rate "$RATE"
tc class add dev "$IFACE" parent 1:1 classid 1:11 htb rate "$RATE"

# Add netem for delay and loss
tc qdisc add dev "$IFACE" parent 1:11 handle 10: netem delay "$DELAY" loss "$LOSS"

echo "[✓] QoS emulation applied to $IFACE."
