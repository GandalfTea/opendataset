
import unittest
from setup import *

class TestDataset(unittest.TestCase):

    # Create

    def test_dataset_creation_invalid_owner(self):
        name = 'demo-dataset'
        owner = 'notexistantowner'
        contributions = 1
        licence = 0
        description = "What is my purpose? Testing."
        readme = "DEMO"
        contribution_guidelines = "DON'T"
        r = rq.post(f"{BASE_API_URL}/create/dataset",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"name": name, "owner": owner}))
        self.assertEqual(r.status_code, 409)

    def test_dataset_creation_no_name(self):
        name = None
        owner = 'demousername'
        contributions = 1
        licence = 0
        description = "What is my purpose? Testing."
        readme = "DEMO"
        contribution_guidelines = "DON'T"
        r = rq.post(f"{BASE_API_URL}/create/dataset",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"name": name, "owner": owner}))
        self.assertEqual(r.status_code, 400)

    def test_dataset_creation_no_owner(self):
        name = 'demo-dataset'
        owner = None
        contributions = 1
        licence = 0
        description = "What is my purpose? Testing."
        readme = "DEMO"
        contribution_guidelines = "DON'T"
        r = rq.post(f"{BASE_API_URL}/create/dataset",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"name": name, "owner": owner}))
        self.assertEqual(r.status_code, 400)

    def test_dataset_creation_correct(self):
        name = 'demo-dataset'
        owner = 'demousername'
        contributions = 1
        licence = 0
        description = "What is my purpose? Testing."
        readme = "DEMO"
        contribution_guidelines = "DON'T"
        r = rq.post(f"{BASE_API_URL}/create/dataset",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"name": name, "owner": owner, "contributions": contributions,
                                     "contribution_guidelines": contribution_guidelines,
                                     "description": description, "licence": licence, "readme": readme}))
        self.assertEqual(r.status_code, 201)

        r = rq.get(f"{BASE_API_URL}/ds/{name}/details")
        r = r.json()
        self.assertEqual(r['contribution_guidelines'], contribution_guidelines)
        self.assertEqual(r['description'], description)
        self.assertEqual(r['num_contributors'], 0)
        self.assertEqual(r['licence'], licence)
        self.assertEqual(r['num_entries'], 0)
        self.assertEqual(r['readme'], readme)

    def test_dataset_creation_dataset_already_exists(self):
        name = 'demo-dataset'
        owner = 'demousername'
        contribution_guidelines = "DON'T"
        r = rq.post(f"{BASE_API_URL}/create/dataset",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"name": name, "owner": owner}))
        self.assertEqual(r.status_code, 409)

    def test_dataset_creation_defaulted_licence(self):
        name = 'demo-dataset_defaulted'
        owner = 'demousername'
        r = rq.post(f"{BASE_API_URL}/create/dataset",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"name": name, "owner": owner}))
        self.assertEqual(r.status_code, 201)

        r = rq.get(f"{BASE_API_URL}/ds/{name}/details")
        r = r.json()
        self.assertEqual(r['licence'], 5)

        r = rq.delete(f"{BASE_API_URL}/ds/{name}")
        # check if deleted


    # File Upload

    def test_dataset_creation_file_upload_csv(self):
        pass
    def test_dataset_creation_file_upload_invalid_csv(self):
        pass
    def test_dataset_creation_file_upload_json(self):
        pass
    def test_dataset_creation_file_upload_invalid_json(self):
        pass    

    def test_dataset_creation_schema_generation_failure(self):
        pass
    def test_dataset_creation_command_generation_failure(self):
        pass
    def test_dataset_creation_illegal_column_names(self):
        pass
    def test_dataset_creation_database_error(self):
        pass


    # Edit

    def test_update_description(self):
        name = 'demo-dataset'
        new_description = "Updated Description"
        r = rq.patch(f"{BASE_API_URL}/ds/{name}/details?q=description",
                     headers={"Content-Type": "application/json"},
                     data = json.dumps({"data": new_description}))
        self.assertEqual(r.status_code, 200)
        r = rq.get(f"{BASE_API_URL}/ds/{name}/details?q=description")
        r = r.json()
        self.assertEqual(r['description'], new_description)

    def test_update_readme(self):
        name = 'demo-dataset'
        new_readme = "Updated Readme"
        r = rq.patch(f"{BASE_API_URL}/ds/{name}/details?q=readme",
                     headers={"Content-Type": "application/json"},
                     data = json.dumps({"data": new_readme}))
        self.assertEqual(r.status_code, 200)
        r = rq.get(f"{BASE_API_URL}/ds/{name}/details?q=readme")
        r = r.json()
        self.assertEqual(r['readme'], new_readme)

    def test_update_licence(self):
        name = 'demo-dataset'
        new_licence = 0 
        r = rq.patch(f"{BASE_API_URL}/ds/{name}/details?q=licence",
                     headers={"Content-Type": "application/json"},
                     data = json.dumps({"data": new_licence}))
        self.assertEqual(r.status_code, 200)
        r = rq.get(f"{BASE_API_URL}/ds/{name}/details?q=licence")
        r = r.json()
        self.assertEqual(r['licence'], new_licence)

    def test_update_guidelines(self):
        name = 'demo-dataset'
        new_guidelines = "Updated Guidelines"
        r = rq.patch(f"{BASE_API_URL}/ds/{name}/details?q=contribution_guidelines",
                     headers={"Content-Type": "application/json"},
                     data = json.dumps({"data": new_guidelines}))
        self.assertEqual(r.status_code, 200)
        r = rq.get(f"{BASE_API_URL}/ds/{name}/details?q=contribution_guidelines")
        r = r.json()
        self.assertEqual(r['contribution_guidelines'], new_guidelines)

    def test_update_contibutors_number(self):
        name = 'demo-dataset'
        new_cont = 42069 
        r = rq.patch(f"{BASE_API_URL}/ds/{name}/details?q=num_contributors",
                     headers={"Content-Type": "application/json"},
                     data = json.dumps({"data": new_cont}))
        self.assertEqual(r.status_code, 200)
        r = rq.get(f"{BASE_API_URL}/ds/{name}/details?q=contribution_guidelines")
        r = r.json()
        print(r)
        self.assertEqual(r['contribution_guidelines'], new_cont)
    
    def test_update_num_entries(self):
        name = 'demo-dataset'
        new_nument = 42069 
        r = rq.patch(f"{BASE_API_URL}/ds/{name}/details?q=num_entries",
                     headers={"Content-Type": "application/json"},
                     data = json.dumps({"data": new_nument}))
        self.assertEqual(r.status_code, 200)
        r = rq.get(f"{BASE_API_URL}/ds/{name}/details?q=num_entries")
        r = r.json()
        self.assertEqual(r['contribution_guidelines'], new_nument)


    # Delete

    def test_dataset_deletion(self):

        #TODO: This causes prev tests to fail

        name = 'demo-dataset'
        #r = rq.delete(f"{BASE_API_URL}/ds/{name}")
        #self.assertEqual(r.status_code, 204)
        # Test if really deleted

if __name__ == "__main__":
    unittest.main()
