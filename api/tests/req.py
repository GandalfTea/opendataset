
import requests as rq
import pprint
import json
import sys
import time

PORT = 3000
VERBOSE = False

# CREATE, EDIT and DELETE Users 
def test_user():

    # CREATE
    print(" > test_user_create:", end='')
    payload = {'username':'demo-user', 'email':'demo-email@example.com'}
    st = time.monotonic()
    r = rq.post(f"http://127.0.0.1:{PORT}/create/user",
                headers={"Content-Type":"application/json"},
                data=json.dumps(payload))
    assert(r.status_code == 200)
    ed = time.monotonic()
    et = ed-st
    print(f"       {et:7f} seconds.")
    if VERBOSE:
        print("Response: ") 
        pprint.pprint(json.loads(r.content.decode()))
        print('')

    # EDIT  . . .
    print(f" > test_user_edit_username SKIPPED")
    print(f" > test_user_edit_email    SKIPPED")

    # DELETE
    print(" > test_user_delete:", end='')
    st = time.monotonic()
    r = rq.delete(f"http://127.0.0.1:{PORT}/users/{payload['username']}")
    assert(r.status_code == 200)
    ed = time.monotonic()
    et = ed-st
    print(f"       {et:7f} seconds.")
    if VERBOSE: 
        print("Response: ") 
        pprint.pprint(json.loads(r.content.decode()))
        print('')


# CREATE, EDIT and DELETE Dataset
def test_dataset():

    # Create
    print("\n > test_database_creation", end='')
    payload = {
        "name":"demo-dataset",
        "owner": "pioneer10",
        "schema": "Name --> STRING(50)\nName--> STRING(50)",
        "contributions": "res",
        "initial_data": "NULL"
    };

    st = time.monotonic()
    r =  rq.post(f"http://127.0.0.1:{PORT}/create/dataset",
                 headers={"Content-Type":"application/json"},
                 data=json.dumps(payload))
    assert(r.status_code == 200)
    ed = time.monotonic()
    et = ed-st
    print(f"              {et:7f} seconds.")
    if VERBOSE: pprint.pprint(r.content.decode())

    # EDIT ...
    print(" > test_database_edit_name             SKIPPED")
    print(" > test_database_edit_contributions    SKIPPED")
    print(" > test_database_edit_schema           SKIPPED")
    print(" > test_database_edit_tests            SKIPPED")
    print(" > test_database_edit_owner            SKIPPED")

    # CONTRIBUTE ...
    print(" > test_database_contribution          SKIPPED")
    print(" > test_database_su_contrib_accept     SKIPPED")

    # DELETE ...
    print(" > test_database_deletion              SKIPPED")

if __name__ == '__main__':
    for arg in sys.argv[1:]:
        if 'PORT' in arg:
            PORT = arg.split('=')[1]
        elif '--verbose' in arg or '-V' in arg:
            VERBOSE=True

    print(f"\nTesting on port: {PORT}", end='')
    print(' with verbose print\b') if VERBOSE else print('\n')
    test_user()
    test_dataset()
