#!/bin/bash

/home/pi/go38-droopy/QRC_droopy.py >/dev/null &

killall -eq droopy
/usr/bin/droopy -d "/home/pi/upload" -m "檔案分享...請掃描 QR Code" -p "/home/pi/go38-droopy/QRC_droopy.png" --dl  >/dev/null &
chromium http://localhost:8000 --start-maximized >/dev/null &
#chromium http://localhost:8000 >/dev/null &
#gpicview /home/pi/QRC_droopy.png
