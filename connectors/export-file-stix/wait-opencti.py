#!/usr/bin/env python3
"""Wait until the OpenCTI platform's /health answers 200, so this service doesn't
crash-loop while the platform is still starting (its first start creates the
Elasticsearch indexes and takes a few minutes). Gives up after WAIT_OPENCTI_TIMEOUT s."""
import os, sys, time, urllib.parse, urllib.request

url = os.environ.get("OPENCTI_URL", "").rstrip("/")
key = os.environ.get("OPENCTI_HEALTH_ACCESS_KEY", "")
if not url or not os.environ.get("OPENCTI_TOKEN"):
    sys.exit("railway-template: OPENCTI_URL and OPENCTI_TOKEN must be set")
check = url + "/health?" + urllib.parse.urlencode({"health_access_key": key})
deadline = time.time() + int(os.environ.get("WAIT_OPENCTI_TIMEOUT", "1800"))
last_log = 0
while True:
    try:
        with urllib.request.urlopen(check, timeout=5) as r:
            if r.status == 200:
                print("railway-template: OpenCTI is up", flush=True)
                break
    except Exception:
        pass
    if time.time() > deadline:
        sys.exit("railway-template: OpenCTI did not become healthy in time")
    if time.time() - last_log > 60:
        print("railway-template: waiting for OpenCTI at " + url, flush=True)
        last_log = time.time()
    time.sleep(5)
