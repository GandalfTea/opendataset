
import unittest
from utils import *

class TestDataset(unittest.TestCase):

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

    def test_dataset_creation_file_upload_csv(self):
        pass
    def test_dataset_creation_file_upload_invalid_csv(self):
        pass
    def test_dataset_creation_file_upload_json(self):
        pass
    def test_dataset_creation_file_upload_invalid_json(self):
        pass

    def test_dataset_deletion(self):
        name = 'demo-dataset'
        r = rq.delete(f"{BASE_API_URL}/ds/{name}")
        self.assertEqual(r.status_code, 204)
        # Test if really deleted

if __name__ == "__main__":
    unittest.main()
