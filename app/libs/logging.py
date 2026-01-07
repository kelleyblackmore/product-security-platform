import json
import sys
import time
import uuid
from typing import Optional

SERVICE_NAME = "psp-service"

def correlation_id_from_headers(x_request_id: Optional[str]) -> str:
    if x_request_id and len(x_request_id) >= 8:
        return x_request_id
    return str(uuid.uuid4())

def log_json(**fields):
    payload = {
        "ts": int(time.time()),
        "service": SERVICE_NAME,
        **fields,
    }
    sys.stdout.write(json.dumps(payload) + "\n")
    sys.stdout.flush()