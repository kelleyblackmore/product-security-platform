import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

import pytest
from fastapi import HTTPException
from libs.auth import require_bearer_token

def test_require_bearer_token_missing():
    with pytest.raises(HTTPException):
        require_bearer_token("")

def test_require_bearer_token_short():
    with pytest.raises(HTTPException):
        require_bearer_token("Bearer abc")

def test_require_bearer_token_ok():
    require_bearer_token("Bearer this-is-a-longer-token")
