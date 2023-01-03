
Requirements:
```bash
$ pip install requests pprint
```

&nbsp;

argv:
```
PORT=[int]          Working port, default 3000
-v, --verbose       Verbose printing of request responses
```
&nbsp;

API Endpoints:

```
/
/users
/users/[username]
/datasets
/datasets/[dataset]

/create/user
POST: 
  {'username': str[50], 'email': str[100] }
  
/create/datasets
POST:
  {
   'name': str[50], 
   'owner': str[50], 
   'contributions': int[ 0 - everyone, 1 - restricted, 2 - only me ], 
   'schema': str[500] 
  }
```

