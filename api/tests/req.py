
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
    payload = {'username':'demo-user', 'email':'demo-email@example.com', 'password':'demopassword'}
    st = time.monotonic()
    r = rq.post(f"http://127.0.0.1:{PORT}/create/user",
                headers={"Content-Type":"application/json"},
                data=json.dumps(payload))
    ed = time.monotonic()
    assert(r.status_code == 200)
    et = ed-st
    print(f"                        {et:7f} seconds.")
    if VERBOSE:
        print("Response: ") 
        pprint.pprint(json.loads(r.content.decode()))
        print('')

    # LOGIN
    print(" > test_user_login_wrong_credentials:", end='')
    correct_payload = {'username': 'demo-user', 'password': 'demopassword'}
    wrong_payload   = {'username': 'demo-user', 'password': 'wrongpassword'}

    st = time.monotonic()
    r = rq.post(f"http://127.0.0.1:{PORT}/login",
            headers={'content-type': 'application/json'},
            data=json.dumps(wrong_payload))
    ed = time.monotonic()
    assert r.status_code == 400, 'wrong password worked.'
    et = ed-st
    print(f"       {et:7f} seconds.")

    print(" > test_user_login_correct_credentials:", end='')
    st = time.monotonic()
    r = rq.post(f"http://127.0.0.1:{PORT}/login",
            headers={'content-type': 'application/json'},
            data=json.dumps(correct_payload))
    ed = time.monotonic()
    assert r.status_code == 200, 'Correct password failed.'
    et = ed-st
    print(f"     {et:7f} seconds.")

    # EDIT  . . .
    print(f" > test_user_edit_username           \t    SKIPPED")
    print(f" > test_user_edit_email              \t    SKIPPED")
    print(f" > test_user_edit_password           \t    SKIPPED")

    # DELETE
    print(" > test_user_delete:", end='')
    st = time.monotonic()
    r = rq.delete(f"http://127.0.0.1:{PORT}/users/{payload['username']}")
    assert(r.status_code == 200)
    ed = time.monotonic()
    et = ed-st
    print(f"                        {et:7f} seconds.")
    if VERBOSE: 
        print("Response: ") 
        pprint.pprint(json.loads(r.content.decode()))
        print('')


# CREATE, EDIT and DELETE Dataset


def test_dataset_creation(test_name, payload, expected_status_code):
    print(f" > {test_name}", end='')
    st = time.monotonic()
    r =  rq.post(f"http://127.0.0.1:{PORT}/create/dataset",
                 headers={"Content-Type":"application/json"},
                 data=json.dumps(payload))
    assert(r.status_code == expected_status_code)
    ed = time.monotonic()
    et = ed-st
    padding = (55-(len(test_name)+3))*' '
    print(f"{padding}{et:7f} seconds.")
    if VERBOSE: pprint.pprint(r.content.decode())


def test_dataset():
    correct_payload = { "name":"demo-dataset", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1" };
    user_not_existant_payload = { "name":"demo-dataset", "owner": "not_existant_user", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1"};
    dataset_already_exists_payload = { "name":"users", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1"};
    #schema_generation_failure_payload = { "name":"users", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1"};
    #command_generation_failure_payload = { "name":"users", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1"};
    #illegal_column_names_payload = { "name":"demo-dataset", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "2"};
    #database_error_payload = { "name":"demo-dataset", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1"};

    test_dataset_creation("test_dataset_creation_correct_payload", correct_payload, 201)
    test_dataset_creation("test_dataset_creation_owner_not_existant", user_not_existant_payload, 404)
    test_dataset_creation("test_dataset_creation_ds_already_exists", dataset_already_exists_payload, 409)

    # Require Demo Data
    #test_dataset_creation("test_dataset_creation_schama_generation_failure", schema_generation_failure_payload, 421)
    #test_dataset_creation("test_dataset_creation_command_generation_failure", command_generation_failure_payload, 421)
    #test_dataset_creation("test_dataset_creation_illegal_column_names", illegal_column_names_payload, 400)
    #test_dataset_creation("test_dataset_creation_database_error", database_error_payload, 500)

    print(" > test_dataset_creation_schama_generation_failure     SKIPPED")
    print(" > test_dataset_creation_command_generation_failure    SKIPPED")
    print(" > test_dataset_creation_illegal_column_names          SKIPPED")
    print(" > test_dataset_creation_database_error                SKIPPED")


    # EDIT 
    print(" > test_database_edit_name                             SKIPPED")
    print(" > test_database_edit_contributions                    SKIPPED")
    print(" > test_database_edit_schema                           SKIPPED")
    print(" > test_database_edit_tests                            SKIPPED")
    print(" > test_database_edit_owner                            SKIPPED")

    # CONTRIBUTE 
    print(" > test_database_contribution                          SKIPPED")
    print(" > test_database_su_contrib_accept                     SKIPPED")

    # DELETE 
    print(" > test_database_deletion                              SKIPPED")

if __name__ == '__main__':
    for arg in sys.argv[1:]:
        if 'PORT' in arg:
            PORT = arg.split('=')[1]
        elif '--verbose' in arg or '-V' in arg:
            VERBOSE=True

    print(f"\nTesting on port: {PORT}", end='')
    print(' with verbose print\b') if VERBOSE else print('\n')
    test_user()
    print('\n')
    test_dataset()
