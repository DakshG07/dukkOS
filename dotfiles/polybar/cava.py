#!/usr/bin/env python3
import os
import struct
import subprocess
import tempfile
import math

BARS_NUMBER = 10
#OUTPUT_BIT_FORMAT = "16bit"
OUTPUT_BIT_FORMAT = "8bit"
# seperators
BAR_SEPERATORS = "▁▂▃▄▅▆▇█"
MAX_SEPERATOR =  len(BAR_SEPERATORS) - 1

conpat = """
[general]
bars = %d
[output]
method = raw
raw_target = /dev/stdout
bit_format = %s
"""

config = conpat % (BARS_NUMBER, OUTPUT_BIT_FORMAT)
bytetype, bytesize, bytenorm = ("H", 2, 65535) if OUTPUT_BIT_FORMAT == "16bit" else ("B", 1, 255)


def run():
    with tempfile.NamedTemporaryFile() as config_file:
        config_file.write(config.encode())
        config_file.flush()

        process = subprocess.Popen(["cava", "-p", config_file.name], stdout=subprocess.PIPE)
        chunk = bytesize * BARS_NUMBER
        fmt = bytetype * BARS_NUMBER

        source = process.stdout

        while True:
            data = source.read(chunk)
            if len(data) < chunk:
                break
            # sample = [i for i in struct.unpack(fmt, data)]  # raw values without norming
            sample = [BAR_SEPERATORS[math.floor(i*MAX_SEPERATOR / bytenorm)] for i in struct.unpack(fmt, data)]
            print(''.join(sample))

if __name__ == "__main__":
    run()
