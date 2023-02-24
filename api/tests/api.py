
import sys
from utils import * 

# CREATE, EDIT and DELETE Users 
def test_user():

    # CREATE
    payload = {'username':'demouser', 'email':'demo-email@example.com', 'password':'demopassword'}
    test("test_user_creation", "POST", "/create/user", 201, payload)

    # LOGIN
    correct_payload = {'username': 'demouser', 'password': 'demopassword'}
    wrong_payload   = {'username': 'demouser', 'password': 'wrongpassword'}
    test("test_user_login_wrong_credentials", "POST", "/login", 400, wrong_payload)
    test("test_user_login_correct_credentials", "POST", "/login", 200, correct_payload)

    # EDIT  . . .
    print(f" > test_user_edit_username                             SKIPPED")
    print(f" > test_user_edit_email                                SKIPPED")
    print(f" > test_user_edit_password                             SKIPPED")

    # DELETE
    test('test_user_delete', 'DELETE', f"/user/{payload['username']}", 200)


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
    updated_description = {"data": "A demo description for a demo world. $$ e^^{i\\pi}=-1"}
    update_readme       = {"data": "A demo README."}
    update_licence      = {"data": 2}
    update_guidelines   = {"data": "#### To contribute to this dataset, please confirm you are conscious."}
    update_num_contrib  = {"data": 42069}
    update_num_entries  = {"data": 4200000}

    test('test_database_update_decription', 'PATCH', f"/dataset/{correct_payload['name']}/details?field=description", 200, updated_description)
    test('test_database_update_readme', 'PATCH', f"/dataset/{correct_payload['name']}/details?field=readme", 200, update_readme)
    test('test_database_update_licence', 'PATCH', f"/dataset/{correct_payload['name']}/details?field=licence", 200, update_licence)
    test('test_database_update_guidelines', 'PATCH', f"/dataset/{correct_payload['name']}/details?field=guidelines", 200, update_guidelines)
    test('test_database_update_contributors_number', 'PATCH', f"/dataset/{correct_payload['name']}/details?field=num_contributors", 200, update_num_contrib)
    test('test_database_update_num_entries', 'PATCH', f"/dataset/{correct_payload['name']}/details?field=num_entries", 200, update_num_entries)
    print(" > test_database_edit_name                             SKIPPED")
    print(" > test_database_edit_schema                           SKIPPED")
    print(" > test_database_edit_tests                            SKIPPED")
    print(" > test_database_edit_owner                            SKIPPED")

    # CONTRIBUTE 
    print(" > test_database_contribution                          SKIPPED")
    print(" > test_database_su_contrib_accept                     SKIPPED")


    # DELETE 
    if NO_DELETE: print(" > test_database_deletion                              SKIPPED")
    else: test('test_database_deletion', 'DELETE', f"/dataset/{correct_payload['name']}", 204)


if __name__ == '__main__':
    for arg in sys.argv[1:]:
        if 'PORT' in arg:
            PORT = arg.split('=')[1]
        elif '--verbose' in arg or '-V' in arg:
            VERBOSE=True
        elif '--no-delete' in arg:
            NO_DELETE=True

    print(f"\nTesting on port: {PORT}", end='')
    print(' with verbose print\b') if VERBOSE else print('\n')
    test_user()
    print('\n')
    test_dataset()
