
API Endpoints:

Datasets

```
GET  /dataset/:dsid                         Returns the whole dataset
GET  /dataset/:dsid/:int                    Return a random subset equal to [ int ] % of dataset. Int is between 1-100
GET  /dataset/:dsid/sample                  Returns a random subset of 50 entries
GET  /dataset/:dsid/details                 Returns the dataset metadata
GET  /dataset/:dsid/details?q=:field        Return specific contributions
GET  /dataset/:dsid/contributions           Return history of contributions
GET  /dataset/:dsid/contributions?id=:id    Returns specific contribution
POST /create/dataset                        Create new dataset
       data: {}
PATCH /dataset/:dsid/details?field=:field   Update dataset frontend details 
       data: {':field' : ' . . . '}
DELETE /dataset/:dsid                       Delete dataset
```

Users
```
GET  /user/:user                            Returns user details
GET  /user/:user/contributions              Return all of the user's contributions
POST /create/user
       data: {}
DELETE /user/:user                          Delete user
```

Meta 
```
POST /login
       data: { 'username' : '...', 'password': '...'}
POST /upvote?ds=:dsid                       Upvote dataset
POST /downvote?ds=:dsid                     Downvote dataset
```
