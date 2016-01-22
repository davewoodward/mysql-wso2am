FROM mysql:latest

ENV VERSION=1.9.1

RUN apt-get update && \
    apt-get install -y zip && \
    apt-get install -y wget && \
    apt-get clean
RUN wget -P /tmp https://s3-us-west-2.amazonaws.com/wso2-stratos/wso2am-$VERSION.zip && \
    unzip /tmp/wso2am-$VERSION.zip -d /tmp
RUN cd /docker-entrypoint-initdb.d && \
    touch apimgtdb.sql && \
    echo "SET @@GLOBAL.innodb_strict_mode='OFF';" >> apimgtdb.sql && \
    echo "SET @@GLOBAL.sql_mode='';" >> apimgtdb.sql && \
    echo "SET @@SESSION.innodb_strict_mode='OFF';" >> apimgtdb.sql && \
    echo "SET @@SESSION.sql_mode='';" >> apimgtdb.sql && \
    echo "create database apimgtdb;" >> apimgtdb.sql && \
    echo "use apimgtdb;" >> apimgtdb.sql && \
    cat /tmp/wso2am-$VERSION/dbscripts/apimgt/mysql.sql >> apimgtdb.sql && \
    touch userdb.sql && \
    echo "SET @@GLOBAL.innodb_strict_mode='OFF';" >> userdb.sql && \
    echo "SET @@GLOBAL.sql_mode='';" >> userdb.sql && \
    echo "SET @@SESSION.innodb_strict_mode='OFF';" >> userdb.sql && \
    echo "SET @@SESSION.sql_mode='';" >> userdb.sql && \
    echo "create database userdb;" >> userdb.sql && \
    echo "use userdb;" >> userdb.sql && \
    cat /tmp/wso2am-$VERSION/dbscripts/mysql.sql >> userdb.sql && \
    touch regdb.sql && \
    echo "SET @@GLOBAL.innodb_strict_mode='OFF';" >> regdb.sql && \
    echo "SET @@GLOBAL.sql_mode='';" >> regdb.sql && \
    echo "SET @@SESSION.innodb_strict_mode='OFF';" >> regdb.sql && \
    echo "SET @@SESSION.sql_mode='';" >> regdb.sql && \
    echo "create database regdb;" >> regdb.sql && \
    echo "use regdb;" >> regdb.sql && \
    cat /tmp/wso2am-$VERSION/dbscripts/mysql.sql >> regdb.sql && \
    rm -r /tmp/wso2am-$VERSION && \
    rm /tmp/wso2am-$VERSION.zip
