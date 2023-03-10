
Simple website for crowd-sourcing dataset creation for data that might not have comercial value.     

&nbsp;

#### Run locally:

`api` and `frontend` are different webservers that both run in express.

&nbsp;
##### API Server:

Import `db.sql` into a PostgreSQL database.     
Create `.env` file in `./api/` with db info:
```bash
PORT=3000
DEBUG=0      // 1 or 2

PGUSER=
PGHOST=
PGPASSWORD=
PGDATABASE=
PGPORT=
```
NOTE: Make sure your postgres user has the `pg_read_server_files` role.   
Compile the TS and start the webserver:
```bash
$ sh compile.sh
```
Or manually using:
```bash
$ tsc ./ts/app.ts --outDir ./compiled/
$ node ./compiled/app.js
```

&nbsp;

The API tests require python `unittest`.
Update the API details in `./api/tests/setup.py`
Run the API tests:
```bash
$ python ./api/tests/test_dataset.py
$ python ./api/tests/test_users.py
$ python ./api/tests/test_sessions.py
```
For demo cURLs and API endpoints see readme in api folder.
      
&nbsp;

##### Frontend server:
Update the API details in `api/src/config.json`.    
```bash
node app.js
```

&nbsp;

#### TODO:
#### 0.1:
* [ ] Manage user accounts
* [ ] Dataset creation and contribution submission
* [ ] SU accept or reject contributions
* [ ] User download full dataset or random subset.
