import sys
from pathlib import Path
sys.path.insert(0, str(Path(__file__).parent.parent.parent))

from libs.logging import correlation_id_from_headers

def test_correlation_id_uses_header():
    cid = correlation_id_from_headers("req-12345678")
    assert cid == "req-12345678"

def test_correlation_id_generates():
    cid = correlation_id_from_headers("")
    assert isinstance(cid, str)
    assert len(cid) > 10
