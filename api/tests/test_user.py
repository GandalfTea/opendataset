
import unittest
from setup import *

class TestUser(unittest.TestCase):

    def test_user_creation_username_contains_illegal_characters(self):
        username = 'demousername$%'
        password = 'demopassword'
        email    = 'demoemail@example.com'
        r = rq.post(f"{BASE_API_URL}/create/user",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"username": username, "password": password, "email": email}))
        self.assertEqual(r.status_code, 422)
        r = rq.get(f"{BASE_API_URL}/user/{username}")
        self.assertFalse(r.json()) # assert empty list
    
    def test_user_creation_email_contails_illegal_characters(self):
        username = 'demousername'
        password = 'demopassword'
        email    = '420demoemail@example.com'
        r = rq.post(f"{BASE_API_URL}/create/user",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"username": username, "password": password, "email": email}))
        self.assertEqual(r.status_code, 422)
        r = rq.get(f"{BASE_API_URL}/user/{username}")
        self.assertFalse(r.json()) # assert empty list

    def test_user_creation_username_too_short(self):
        username = 'dem'
        password = 'demopassword'
        email    = '420demoemail@example.com'
        r = rq.post(f"{BASE_API_URL}/create/user",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"username": username, "password": password, "email": email}))
        self.assertEqual(r.status_code, 422)
        r = rq.get(f"{BASE_API_URL}/user/{username}")
        self.assertFalse(r.json()) # assert empty list

    def test_user_creation_username_too_long(self):
        username = 'demousernamedemousernamedemousername'
        password = 'demopassword'
        email    = '420demoemail@example.com'
        r = rq.post(f"{BASE_API_URL}/create/user",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"username": username, "password": password, "email": email}))
        self.assertEqual(r.status_code, 422)
        r = rq.get(f"{BASE_API_URL}/user/{username}")
        self.assertFalse(r.json()) # assert empty list

    def test_user_creation_correct(self):
        username = 'demousername'
        password = 'demopassword'
        email    = 'demoemail@example.com'
        r = rq.post(f"{BASE_API_URL}/create/user",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"username": username, "password": password, "email": email}))
        self.assertEqual(r.status_code, 201)
        r = rq.get(f"{BASE_API_URL}/user/{username}")
        res = r.json()[0]
        self.assertEqual(res['username'], username)
        self.assertEqual(res['email'], email)


    # TODO: Test email regex

    def test_login_incorrect_username(self):
        username = 'fakeuser'
        password = 'demopassword'
        email    = 'demoemail@example.com'
        r = rq.delete(f"{BASE_API_URL}/login",
                      headers={"Content-Type": "application/json"},
                      data=json.dumps({"username": username, "password": password}))
        self.assertEqual(r.status_code, 400)

    def test_login_incorrect_password(self):
        username = 'demousername'
        password = 'wrong'
        email    = 'demoemail@example.com'
        r = rq.delete(f"{BASE_API_URL}/login",
                      headers={"Content-Type": "application/json"},
                      data=json.dumps({"username": username, "password": password}))
        self.assertEqual(r.status_code, 400)

    def test_login_correct(self):
        username = 'demousername'
        password = 'demopassword'
        email    = 'demoemail@example.com'
        r = rq.delete(f"{BASE_API_URL}/login",
                      headers={"Content-Type": "application/json"},
                      data=json.dumps({"username": username, "password": password}))
        self.assertEqual(r.status_code, 200)

    def test_user_deletion_correct(self):
        username = 'demousername'
        password = 'demopassword'
        email    = 'demoemail@example.com'
        r = rq.delete(f"{BASE_API_URL}/user/{username}",
                      headers={"Content-Type": "application/json"},
                      data=json.dumps({"username": username, "password": password, "email": email}))
        self.assertEqual(r.status_code, 200)
        r = rq.get(f"{BASE_API_URL}/user/{username}")
        self.assertFalse(r.json()) # assert empty list

    def test_user_deletion_incorrect_username(self):
        username = 'demousername'
        password = 'demopassword'
        email    = 'demoemail@example.com'
        r = rq.delete(f"{BASE_API_URL}/user/{username}",
                      headers={"Content-Type": "application/json"},
                      data=json.dumps({"username": username, "password": password, "email": email}))
        self.assertEqual(r.status_code, 404)


if __name__ == "__main__":
    unittest.main()

