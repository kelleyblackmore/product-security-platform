from fastapi import FastAPI, Header, HTTPException
from src.libs.logging import log_json
from src.libs.auth import require_bearer_token

app = FastAPI()

@app.get("/healthz")
def healthz():
    return {"ok": True}

@app.get("/hello")
def hello(authorization: str = Header(default="")):
    require_bearer_token(authorization)
    log_json(event="hello_called")
    return {"message": "hello"}