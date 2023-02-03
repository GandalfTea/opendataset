
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

`api` and `frontend` are different webservers that both run in express.

&nbsp;
##### API Server:

Import `db.sql` into a PostgreSQL database.     
Update information in `./api/ts/db.ts` with your login credentials.     
NOTE: Make sure you have the `pg_read_server_files` role.   
Default `PORT` is `3000`, change this in `./api/ts/app.ts`.      
Compile the TS and start the webserver:
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
$ python ./tests/api.py
```
For demo cURLs see readme in api folder.
      
&nbsp;

##### Frontend server:
Update the details in `api/src/config.json`.    
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
