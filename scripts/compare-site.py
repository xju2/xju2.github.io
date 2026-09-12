"""Compare public HTML routes and downloadable PDFs across a theme migration."""
import hashlib
from pathlib import Path
import sys

before, after = map(Path, sys.argv[1:3])
old_routes = {p.relative_to(before) for p in before.rglob("*.html")}
new_routes = {p.relative_to(after) for p in after.rglob("*.html")}
missing = old_routes - new_routes
assert old_routes, "Baseline build is empty"
assert not missing, f"Removed routes: {sorted(map(str, missing))}"
pdfs = list(before.rglob("*.pdf"))
for old in pdfs:
    new = after / old.relative_to(before)
    assert new.is_file(), f"Missing download: {new}"
    assert hashlib.sha256(old.read_bytes()).digest() == hashlib.sha256(new.read_bytes()).digest(), f"Changed download: {new}"
for path in ("CNAME", "talkmap/map.html"):
    assert (before / path).read_bytes() == (after / path).read_bytes(), f"Changed {path}"
print(f"Preserved {len(old_routes)} HTML routes and {len(pdfs)} PDFs, CNAME and talk map.")
