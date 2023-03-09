
import unittest
from setup import *

class TestSessions(unittest.TestCase):
    
    def setUp(self):
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

    def test_login(self):
        session = rq.Session()

        username = 'demousername'
        password = 'demopassword'
        r = rq.post(f"{BASE_API_URL}/login",
                    headers={"Content-Type": "application/json"},
                    data=json.dumps({"username": username, "password": password}))
        self.assertEqual(r.status_code, 200)
        print(r)
        session.get(f"{BASE_API_URL}/user/{username}")
        print(session.cookies.get_dict())
        

if __name__ == "__main__":
    unittest.main()
