"""Exercise the migrated theme against a local build; save review screenshots."""
from pathlib import Path
from playwright.sync_api import sync_playwright
import functools
import http.server
import threading
import os
import sys

def report(result):
    print(result)
    if "GITHUB_OUTPUT" in os.environ:
        with open(os.environ["GITHUB_OUTPUT"], "a") as output:
            output.write("result=" + result.replace("\n", " ")[:200] + "\n")

def failure(kind, error, traceback):
    report(f"{globals().get('width', 'startup')} {globals().get('route', '')}: {str(error) or kind.__name__}")
    sys.__excepthook__(kind, error, traceback)

sys.excepthook = failure

root = Path("_browser-site").resolve()
server = http.server.ThreadingHTTPServer(("127.0.0.1", 4000), functools.partial(http.server.SimpleHTTPRequestHandler, directory=str(root)))
threading.Thread(target=server.serve_forever, daemon=True).start()
shots = Path("browser-results")
shots.mkdir(exist_ok=True)
errors = []
with sync_playwright() as p:
    browser = p.chromium.launch()
    page = browser.new_page(viewport={"width": 1440, "height": 1000})
    page.on("pageerror", lambda error: errors.append(str(error)))
    page.on("response", lambda response: errors.append(f"{response.status}: {response.url}") if response.url.startswith("http://127.0.0.1:4000/") and response.status >= 400 else None)
    for width in (1440, 390):
        page.set_viewport_size({"width": width, "height": 1000})
        for route in ("/", "/projects/", "/publications/", "/talks/", "/students/", "/terms/"):
            page.goto("http://127.0.0.1:4000" + route, wait_until="networkidle")
            page.wait_for_function("window.jQuery && jQuery.fn.jquery === '3.7.1'")
            assert page.locator("h1").first.inner_text().strip(), "Missing heading"
            assert page.locator(".author__avatar img").evaluate("(img) => img.complete && img.naturalWidth > 0"), "Profile image failed"
            if route == "/":
                page.wait_for_selector("mjx-container", timeout=60000)
                assert page.locator('a[href*="scholar.google.com"]').count(), "Scholar link missing"
                assert page.locator('a[href*="orcid.org"]').count(), "ORCID link missing"
                for href in ("mailto:xju@lbl.gov", "https://github.com/xju2", "https://www.linkedin.com/in/xiangyangju2015"):
                    assert page.locator(f'.author__urls a[href="{href}"]').count() == 1, f"Contact link missing or duplicated: {href}"
                if width == 390:
                    page.locator(".author__urls-wrapper button").click()
                    assert page.locator(".author__urls").is_visible(), "Follow menu did not open"
                    page.locator(".author__urls-wrapper button").click()
                    toggle = page.locator(".greedy-nav__toggle")
                    assert toggle.is_visible(), "Navigation toggle missing"
                    toggle.click()
                    assert page.locator(".greedy-nav .hidden-links").is_visible(), "Navigation menu did not open"
                    toggle.click()
            if route == "/publications/":
                button = page.get_by_role("button", name="BibTeX", exact=False).first
                button.click()
                assert page.locator('.bibTexContainer:visible').count() > 0, 'BibTeX did not expand'
                assert "@" in page.locator('.bibTexContainer:visible').inner_text(), "Citation text missing"
                button.click()
                assert page.locator('.bibTexContainer:visible').count() == 0, "BibTeX did not collapse"
            if route == "/students/":
                rows = page.locator(".students-table tbody tr")
                assert rows.count() > 0, "No student rows"
                assert all(rows.nth(i).locator("td").count() == 8 for i in range(rows.count())), "Student column counts: " + str([rows.nth(i).locator("td").count() for i in range(rows.count())])
            page.screenshot(path=str(shots / f"{route.strip('/') or 'home'}-{width}.png"), full_page=True)
    browser.close()
server.shutdown()
assert not errors, "\n".join(errors)
report("Desktop/mobile routes, menus, math, BibTeX and student rows passed.")
