
import requests as rq
import pprint
import json


PORT = 3000

payload = {
    "username":"demo-username",
    "password": "demo-password",
    "schema": {
        "name":"char[64]",
        "profession":"char[64]",
        "age":"int8"
    },
    "initial_data": "NULL"
};


r =  rq.post(f"http://127.0.0.1:{PORT}/new/dataset",
             headers={"Content-Type":"application/json"},
             data=json.dumps(payload))
pprint.pprint(json.loads(r.content))
