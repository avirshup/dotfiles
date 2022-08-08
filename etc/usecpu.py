#!/usr/bin/env python
# keep the CPU powered in my 2014 macbook pro so that it doesn't crash
# fuck you tim apple
# https://forums.macrumors.com/threads/help-updated-to-macos-10-12-4-mbp-randomly-shuts-off.2039446

import time

x = 0
while True:
    time.sleep(0.00002)
    x = (x + 1) % 1024

