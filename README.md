# White-Pages

White Pages is a PHP application that allows users to search and display data stored in an LDAP directory. 

Website : https://ltb-project.org/documentation/white-pages


## LDAP parameters

Tune your ldap parameters in a init-ldap.txt file like this :

```
   LDAP_URL=ldap://ldap.example.com
   LDAP_STARTTLS=false
   LDAP_BINDDN=uid=your-user,ou=Users,dc=example,dc=com
   LDAP_BINDPW=your-password
   LDAP_BASE=dc=example,dc=com
   LDAP_USER_BASE=ou=Users
   LDAP_USER_FILTER=(objectClass=inetOrgPerson)
   LDAP_SIZE_LIMIT=50
```

Default values are probably not suitable for your installation...

## Run

Run a container using your init-ldap.txt to set environment variables. 

```shell
docker run --rm -it --name test --hostname wp.local --env-file init-ldap.txt -p 8000:80 actilis/white-pages
```

Point your browser to http://your-docker-engine:8000/.

