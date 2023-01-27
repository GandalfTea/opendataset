
Simple website for crowd-sourcing dataset creation for data that might not have comercial value.     
Like a very shitty GitHub, for now.    

&nbsp;

#### Dependencies:      
Backend: `typescript`, `express`, PostgreSQL, `multer`, `pg`       
Frontend:      
* `react`, `socket.io`, `pug`,      
* `react-markdown`, `react-mathjax`, `remark-math`          

Python: `pandas`  

&nbsp;

#### Run locally:

`api` and `frontend` are different webservers that both run on express and node

&nbsp;
##### API Server:

Import `db.sql` into a PostgreSQL database.     
Update `node-postgres` client information in `./api/ts/db.ts` with your login credentials.     
Make sure your Postgres user has the `pg_read_server_files` role.   
Default `PORT` is `3000` and `DEBUG` is `false`, change this in `./api/ts/app.ts`.      
Compile the TS using `tsc` and start the webserver:
```bash
$ sh compile.sh
```
Or manually using:
```bash
$ tsc ./ts/app.ts --outDir ./compiled/
$ node ./compiled/app.js
```
Run the API tests:
```bash
$ python ./tests/req.py
```
Use the demo forms in `./frontend` or make requests using cURL     
In order to upload files to a HTML form, it needs `enctype="multipart/form-data"`.
      
&nbsp;

##### Frontend server:
```bash
REACT_APP_API_BASE_DIR= { your api url }:PORT node app.js
```

&nbsp;

#### TODO:
#### 0.1:
* [ ] Manage user accounts
* [ ] Dataset creation and contribution submission
* [ ] SU accept or reject contributions
* [ ] User download full dataset or random subset.
