
import requests as rq
import pprint
import json
import sys
import time

PORT = 3000
VERBOSE = False
NO_DELETE = False
BASE_API_URL = "http://127.0.0.1:3000"

def test(test_name, req_type, req_url, expected_status_code, payload={}):
    print(f" > {test_name}", end='')
    API_BASE_URL = f"http://127.0.0.1:{PORT}"
    st = time.monotonic()
    try:
        if req_type=='POST':
            r = rq.post(f"{API_BASE_URL}{req_url}",
                    headers={"Content-Type":"application/json"},
                    data=json.dumps(payload))
        elif req_type=='GET':
            r = rq.get(f"{API_BASE_URL}{req_url}")
        elif req_type=='DELETE':
            r = rq.delete(f"{API_BASE_URL}{req_url}")
        elif req_type=='PATCH':
            r = rq.patch(f"{API_BASE_URL}{req_url}",
                    headers={"Content-Type":"application/json"},
                    data=json.dumps(payload))
        else:
            raise ValueError("URL Request Type not valid.")
        assert r.status_code == expected_status_code

    except ConnectionError as err:
        print(err.args)
    except ValueError as err:
        print(err.args)
    except AssertionError as err:
        padding = (55-(len(test_name)+3))*' '
        print(f"{padding}FAILED: Status code asserion failed. Expected {expected_status_code} and got {r.status_code}.")
    except:
        padding = (55-(len(test_name)+3))*' '
        print(f"{padding}FAILED. Unknown reason.")
    else:
        ed = time.monotonic()
        et = ed-st
        padding = (55-(len(test_name)+3))*' '
        print(f"{padding}{et:7f} seconds.")
        if VERBOSE: pprint.pprint(r.content.decode())

