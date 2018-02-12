# WSO2 API Manager MySQL Databases
This project may be used to build a docker image that can be run to prepare the three databases required by the WSO2 API Manager platform.

The databases created include:
* apimgtdb
* regdb
* userdb

## How to Use
1. Run the image counterpart of this manifest available on [Docker Hub](https://hub.docker.com/r/salte/mysql-wso2am/) via the following command:
```bash
$ docker run --name wso2db --restart=always --detach \
             --publish 3306:3306 \
             --volume wso2db:/var/lib/mysql \
             -e MYSQL_ROOT_PASSWORD=<password> \
             -e MYSQL_USER=<username> \
             -e MYSQL_PASSWORD=<password> \
             mysql-wso2am:<tag>
```
*For a complete breakdown of the parameters supported, see the MySQL database image available on [Docker Hub](https://hub.docker.com/_/mysql/).*

2. Run the corresponding application server image available on [Docker Hub](https://hub.docker.com/r/salte/wso2am/).