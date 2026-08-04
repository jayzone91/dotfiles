#!/usr/bin/env bash

set -euo pipefail

DEVICE="/dev/hidraw10"
MOUSE="G502 X PLUS"
MAUVE="0xCBA6F7"

solaar -D "$DEVICE" config "$MOUSE" onboard_profiles Disabled
solaar -D "$DEVICE" config "$MOUSE" report_rate 1ms
solaar -D "$DEVICE" config "$MOUSE" dpi 2600

solaar -D "$DEVICE" config "$MOUSE" rgb_control true
solaar -D "$DEVICE" config "$MOUSE" rgb_zone_1 Static

solaar -D "$DEVICE" config "$MOUSE" per-key-lighting \
  "{1:${MAUVE},2:${MAUVE},3:${MAUVE},4:${MAUVE},5:${MAUVE},6:${MAUVE},7:${MAUVE},8:${MAUVE}}"

solaar -D "$DEVICE" config "$MOUSE" rgb_idle_timeout "1 Minute"
solaar -D "$DEVICE" config "$MOUSE" rgb_sleep_timeout "5 Minutes"