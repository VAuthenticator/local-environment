# local-environment

The project is composed by a docker-compose yml designed to provide you all the basic infrastructure to start
vauthenticator app in local.

# local host config

- add on your local hosts file the following configurations

    ```
    127.0.0.1   local.assets.vauthenticator.com
    127.0.0.1   local.api.vauthenticator.com
    127.0.0.1   local.management.vauthenticator.com
    ```
- make sure that you have a clean installation 
  - docker-compose down  
  - docker-compose rm  
  - clean if already there the docker folder on the project root. In this folder will be placed the dynamodb storage 

- run the setup.sh
  ```
  After that the setup.sh is executed in the project root you should have a file called `kms.logs`. 
  The content of this file is the master key to insert in the configuration
  file configuration/Fvauthenticator.yml.
  Property name is: `key.master-key: ${A_MASTER_KEY}`
  Property name is: `: ${VAUTHENTICATOR_DOCUMENTS_BUCKET}`
  ```
  
- default dev credentials management ui:
  - link:  http://local.management.vauthenticator.com:8080/secure/admin/index
  - username: admin@email.com
  - password: admin
  - 
- default dev credentials admin M2M client application :
  - username: admin
  - password: secret