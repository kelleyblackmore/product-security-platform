import json
import sys
import time

def log_json(**fields):
    payload = {
        "ts": int(time.time()),
        "service": "psp-service",
        **fields,
    }
    sys.stdout.write(json.dumps(payload) + "\n")
    sys.stdout.flush()