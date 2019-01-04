FROM anapsix/alpine-java:8_server-jre_unlimited

MAINTAINER ryugei <liuyi@chinacloud.com.cn>

ARG TOMCAT_VERSION=8.0.53
ARG TOMCAT_HOME=/opt/tomcat

ENV CATALINA_HOME=/opt/tomcat \
    CATALINA_OUT=/dev/null

ENV PATH $PATH:$CATALINA_HOME/bin

RUN sed -i 's@http://dl-cdn.alpinelinux.org@http://mirrors.chinacloud.com.cn@g' /etc/apk/repositories \
    && apk upgrade --update \
    && apk add --no-cache curl \
    && curl -jksSL -o /tmp/apache-tomcat.tar.gz http://mirrors.chinacloud.com.cn/tomcat/apache-tomcat-${TOMCAT_VERSION}.tar.gz \
    && gunzip /tmp/apache-tomcat.tar.gz \
    && tar -C /opt -xf /tmp/apache-tomcat.tar \
    && ln -s /opt/apache-tomcat-${TOMCAT_VERSION} ${TOMCAT_HOME} \
    && apk del curl \
    && rm -rf ${TOMCAT_HOME}/webapps/* ${TOMCAT_HOME}/bin/*.bat /tmp/* /var/cache/apk/*

EXPOSE 8080
