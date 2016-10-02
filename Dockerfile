FROM mysql:latest

ENV VERSION=2.0.0

RUN apt-get update && \
    apt-get install -y zip && \
    apt-get install -y wget && \
    apt-get clean
RUN wget -P /tmp http://192.168.1.50:8091/repository/wso2/api/$VERSION/platform.zip && \
    unzip /tmp/platform -d /tmp
RUN cd /docker-entrypoint-initdb.d && \
    touch apimgtdb.sql && \
    echo "SET @@GLOBAL.innodb_strict_mode='OFF';" >> apimgtdb.sql && \
    echo "SET @@GLOBAL.sql_mode='';" >> apimgtdb.sql && \
    echo "SET @@SESSION.innodb_strict_mode='OFF';" >> apimgtdb.sql && \
    echo "SET @@SESSION.sql_mode='';" >> apimgtdb.sql && \
    echo "create database apimgtdb;" >> apimgtdb.sql && \
    echo "use apimgtdb;" >> apimgtdb.sql && \
    cat /tmp/wso2am-$VERSION/dbscripts/apimgt/mysql.sql >> apimgtdb.sql && \
    echo "grant all privileges on apimgtdb.* to 'apimgr'@'%';" >> apimgtdb.sql && \
    echo "flush privileges;" >> apimgtdb.sql && \
    touch userdb.sql && \
    echo "SET @@GLOBAL.innodb_strict_mode='OFF';" >> userdb.sql && \
    echo "SET @@GLOBAL.sql_mode='';" >> userdb.sql && \
    echo "SET @@SESSION.innodb_strict_mode='OFF';" >> userdb.sql && \
    echo "SET @@SESSION.sql_mode='';" >> userdb.sql && \
    echo "create database userdb;" >> userdb.sql && \
    echo "use userdb;" >> userdb.sql && \
    cat /tmp/wso2am-$VERSION/dbscripts/mysql.sql >> userdb.sql && \
    echo "grant all privileges on userdb.* to 'apimgr'@'%';" >> userdb.sql && \
    echo "flush privileges;" >> userdb.sql && \
    touch regdb.sql && \
    echo "SET @@GLOBAL.innodb_strict_mode='OFF';" >> regdb.sql && \
    echo "SET @@GLOBAL.sql_mode='';" >> regdb.sql && \
    echo "SET @@SESSION.innodb_strict_mode='OFF';" >> regdb.sql && \
    echo "SET @@SESSION.sql_mode='';" >> regdb.sql && \
    echo "create database regdb;" >> regdb.sql && \
    echo "use regdb;" >> regdb.sql && \
    cat /tmp/wso2am-$VERSION/dbscripts/mysql.sql >> regdb.sql && \
    echo "grant all privileges on regdb.* to 'apimgr'@'%';" >> regdb.sql && \
    echo "flush privileges;" >> regdb.sql && \
    rm -r /tmp/wso2am-$VERSION && \
    rm /tmp/platform.zip
RUN wget -P /opt https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.0/flyway-commandline-4.0-linux-x64.tar.gz && \
    cd /opt && \
    tar -xvf flyway-commandline-4.0-linux-x64.tar.gz && \
    rm flyway-commandline-4.0-linux-x64.tar.gz

ENV PATH $PATH:/opt/flyway-4.0
