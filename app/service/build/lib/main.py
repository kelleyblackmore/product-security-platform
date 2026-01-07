from fastapi import FastAPI, Header
from src.libs.logging import log_json, correlation_id_from_headers
from src.libs.auth import require_bearer_token

app = FastAPI()

@app.get("/healthz")
def healthz():
    return {"ok": True}

@app.get("/hello")
def hello(authorization: str = Header(default=""), x_request_id: str = Header(default="")):
    require_bearer_token(authorization)
    cid = correlation_id_from_headers(x_request_id)
    log_json(event="hello_called", correlation_id=cid)
    return {"message": "hello", "correlation_id": cid}