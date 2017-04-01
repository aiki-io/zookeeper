FROM openjdk:8-jre-alpine
MAINTAINER lech@aiki.io

ENV ZK_VERSION=3.4.10 
RUN apk add --no-cache bash && \

    mkdir /opt && \
    mkdir /data && \
    wget -q http://apache.org/dist/zookeeper/zookeeper-$ZK_VERSION/zookeeper-$ZK_VERSION.tar.gz -O /tmp/zookeeper-$ZK_VERSION.tar.gz && \
    tar -xzf /tmp/zookeeper-$ZK_VERSION.tar.gz -C /opt && \
    rm -f /tmp/zookeeper-$ZK_VERSION.tar.gz && \
    ln -s /opt/zookeeper-$ZK_VERSION/ /opt/zookeeper && \
    mv /opt/zookeeper/conf/zoo_sample.cfg /opt/zookeeper/conf/zoo.cfg && \
    addgroup zk && \
    adduser -S zk -G zk && \ 
    sed  -i "s|/tmp/zookeeper|/data|g" /opt/zookeeper/conf/zoo.cfg && \
    chown -R zk:zk /data && \
    chown -R zk:zk /opt/zookeeper
    
EXPOSE 2181
VOLUME ["/data"]
WORKDIR /opt/zookeeper
USER zk
    
CMD ["bin/zkServer.sh", "start-foreground"]

