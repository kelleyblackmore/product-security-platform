from fastapi import HTTPException

def require_bearer_token(authorization: str):
    # This is intentionally minimal: in real usage validate JWT (iss/aud/exp) via JWKS
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="missing/invalid auth token")