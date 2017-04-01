FROM openjdk:8-jre-alpine
MAINTAINER lech@aiki.io

ENV ZK_VERSION=3.4.10 
RUN apk add --update bash wget && \
    rm -rf /var/cache/apk/* && \
    mkdir /opt && \
    mkdir /data && \
    wget -q http://apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz -O /tmp/zookeeper-$ZK_VERSION.tar.gz && \
    tar -xzf /tmp/zookeeper-$ZK_VERSION.tar.gz -C /opt && \
    ln -s /opt/zookeeper-$ZK_VERSION/ /opt/zookeeper && \
    mv /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg && \
    addgroup zoo && \
    adduser -S zoo -G zoo && \ 
    sed  -i "s|/tmp/zookeeper|/data|g" /opt/zookeeper/conf/zoo.cfg && \
    chown -R zoo:zoo /data && \
    chown -R zoo:zoo /opt/zookeeper
    
EXPOSE 2181
VOLUME ["/data"]
WORKDIR /opt/zookeeper
USER zoo
    
ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh", "start-foreground"]

