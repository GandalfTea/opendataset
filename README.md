

Simple website for crowd-sourcing dataset creation for data that might not have comercial value.    
Backend is Express.js and PostgreSQL while frontend is React.js and Socket.io.     
It allows the user to upload .csv files, automatically generates a schema using `pandas` in a python script and uploads the data into the database. 
      
Backend also requires : `multer`, `pg` and `uuid`. 
      
      
&nbsp;

#### 0.1:
* Manage user accounts
* Dataset creation and contribution submission
* SU accept or reject contributions
* User download full dataset or random subset.

#### 0.2:
* Contributions basic testing
* Personalised contributions testing
* CLI contributions

#### 0.3:
* Serialise and cache datasets properties to make them searchable
* Search page

#### 0.4:
* user interactions: DMs, Forums, Comments
