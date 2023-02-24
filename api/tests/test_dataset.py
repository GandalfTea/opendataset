

import unittest
from utils import *

class TestDataset(unittest.TestCase):

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
                    data=json.dumps({"name": name, "owner": owner, "contributions": contributions}))
        self.assertEqual(r.status_code, 201)

        r = rq.get(f"{BASE_API_URL}/ds/{name}/details")
        r = r.json()
        self.assertEqual(r['contribution_guidelines'], contribuition_guidelines)
        self.assertEqual(r['description'], description)
        self.assertEqual(r['num_contributors'], 0)
        self.assertEqual(r['licence'], licence)
        self.assertEqual(r['num_entries'], 0)
        self.assertEqual(r['readme'], readme)

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
                    data=json.dumps({"name": name, "owner": owner, "contributions": contributions}))
        self.assertEqual(r.status_code, 400)

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
                    data=json.dumps({"name": name, "owner": owner, "contributions": contributions}))
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
                    data=json.dumps({"name": name, "owner": owner, "contributions": contributions}))
        self.assertEqual(r.status_code, 201)

    def test_dataset_creation_dataset_already_exists(self):
        pass
    def test_dataset_creation_defaulted_licence(self):
        pass
    def test_dataset_creation_defaulted_contribution_option(self):
        pass
    def test_dataset_creation_file_upload_csv(self):
        pass
    def test_dataset_creation_file_upload_invalid_csv(self):
        pass
    def test_dataset_creation_file_upload_json(self):
        pass
    def test_dataset_creation_file_upload_invalid_json(self):
        pass

if __name__ == "__main__":
    unittest.main()
