
API Endpoints:

Datasets

```
GET  /dataset/:dsid/                        Returns the whole dataset
GET  /dataset/:dsid/demo                    Returns a random subset of 50 entries
GET  /dataset/:dsid/details                 Returns the dataset metadata
GET  /dataset/:dsid/details?q=:field        Return specific contributions
GET  /dataset/:dsid/contributions           Return history of contributions
GET  /dataset/:dsid/contributions?id=:id    Returns specific contribution
POST /dataset/:dsid/details?field=:field    Update dataset frontend details 
       data: {':field' : ' . . . '}
POST /create/dataset                        Create new dataset
       data: {}
```

Users
```
GET  /user/:user                            Returns user details
GET  /user/:user/contributions              Return all of the user's contributions
POST /create/user
       data: {}
```

Meta 
```
POST /login
       data: { 'username' : '...', 'password': '...'}
POST /upvote?ds=:dsid                       Upvote dataset
POST /downvote?ds=:dsid                     Downvote dataset
```
