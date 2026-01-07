from fastapi import HTTPException

def require_bearer_token(authorization: str):
    """
    Minimal demo for the repo. Production version should validate:
      - JWT signature using JWKS
      - iss/aud/exp/nbf
      - scopes/roles claims
    """
    if not authorization or not authorization.startswith("Bearer "):
        raise HTTPException(status_code=401, detail="missing/invalid auth token")
    token = authorization.replace("Bearer ", "", 1).strip()
    if len(token) < 10:
        raise HTTPException(status_code=401, detail="missing/invalid auth token")