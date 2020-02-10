#!/usr/bin/env python3

import time

# Start timer
stt = time.time()
# Stop timer
hours, rem = divmod((time.time() - stt), 3600)
minutes, sec = divmod(rem, 60)
print("Elapsed Time:\n{:0>2}:{:0>2}:{:05.2f}".format(
    int(hours), int(minutes), sec))
