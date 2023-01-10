
import requests as rq
import pprint
import json
import sys
import time

PORT = 3000
VERBOSE = False

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

# CREATE, EDIT and DELETE Users 
def test_user():

    # CREATE
    payload = {'username':'demo-user', 'email':'demo-email@example.com', 'password':'demopassword'}
    test("test_user_creation", "POST", "/create/user", 200, payload)

    # LOGIN
    correct_payload = {'username': 'demo-user', 'password': 'demopassword'}
    wrong_payload   = {'username': 'demo-user', 'password': 'wrongpassword'}

    test("test_user_login_wrong_credentials", "POST", "/login", 400, wrong_payload)
    test("test_user_login_correct_credentials", "POST", "/login", 200, correct_payload)

    # EDIT  . . .
    print(f" > test_user_edit_username                             SKIPPED")
    print(f" > test_user_edit_email                                SKIPPED")
    print(f" > test_user_edit_password                             SKIPPED")

    # DELETE
    test('test_user_delete', 'DELETE', f"/users/{payload['username']}", 200)


# CREATE, EDIT and DELETE Dataset

def test_dataset():
    correct_payload = { "name":"demo-dataset", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1" };
    user_not_existant_payload = { "name":"demo-dataset", "owner": "not_existant_user", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1"};
    dataset_already_exists_payload = { "name":"users", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1"};
    #schema_generation_failure_payload = { "name":"users", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1"};
    #command_generation_failure_payload = { "name":"users", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1"};
    #illegal_column_names_payload = { "name":"demo-dataset", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "2"};
    #database_error_payload = { "name":"demo-dataset", "owner": "GandalfTea", "schema": "Name --> STRING(50)\nName--> STRING(50)", "contributions": "1"};

    test("test_dataset_creation_correct_payload",    'POST', '/create/dataset', 201, correct_payload)
    test("test_dataset_creation_owner_not_existant", 'POST', '/create/dataset', 404, user_not_existant_payload)
    test("test_dataset_creation_ds_already_exists",  'POST', '/create/dataset', 409, dataset_already_exists_payload)

    # Require Demo Data
    #test_dataset_creation("test_dataset_creation_schama_generation_failure", schema_generation_failure_payload, 421)
    #test_dataset_creation("test_dataset_creation_command_generation_failure", command_generation_failure_payload, 421)
    #test_dataset_creation("test_dataset_creation_illegal_column_names", illegal_column_names_payload, 400)
    #test_dataset_creation("test_dataset_creation_database_error", database_error_payload, 500)

    print(" > test_dataset_creation_schama_generation_failure     SKIPPED")
    print(" > test_dataset_creation_command_generation_failure    SKIPPED")
    print(" > test_dataset_creation_illegal_column_names          SKIPPED")
    print(" > test_dataset_creation_database_error                SKIPPED")

    test("test_dataset_frontend", 'GET', f"/dataset/{correct_payload['name']}/details", 200)

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
    test('test_database_deletion', 'DELETE', f"/dataset/{correct_payload['name']}", 204)




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
