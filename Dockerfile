FROM ubuntu:bionic

ARG DEBIAN_FRONTEND=noninteractive

ENV JAVA_HOME /opt/jdk1.8.0_201
ENV PATH /opt/autopsy/bin:${JAVA_HOME}/bin:$PATH

COPY --from=bannsec/autopwn-stage-j8 /tmp/jdk* /opt/.

RUN apt-get update && apt-get install -y \
        apt-utils \
        curl \
        dnsutils \
        libafflib0v5 \
        libafflib-dev \
        libboost-all-dev \
        libboost-dev \
        libc3p0-java \
        libewf2 \
        libewf-dev \
        libpostgresql-jdbc-java \
        libpq5 \
        libsqlite3-dev \
        libvhdi1 \
        libvhdi-dev \
        libvmdk1 \
        libvmdk-dev \
        openjfx \
        testdisk \
        unzip \
        wget \
        xauth \
        x11-apps \
        x11-utils \
        x11proto-core-dev \
        x11proto-dev \
        xkb-data \
        xorg-sgml-doctools \
        xtrans-dev \
    && rm -rf /var/lib/apt/lists/*
RUN RELEASE_PATH=`curl -sL https://github.com/sleuthkit/autopsy/releases/latest \
        | grep -Eo 'href=".*.zip' \
        | grep -v archive \
        | head -1 \
        | cut -d '"' -f 2` \
    && mkdir -p /opt \
    && cd /opt \
    && curl -L https://github.com/${RELEASE_PATH} > autopsy.zip \
    && mkdir autopsy \
    && unzip -d autopsy autopsy.zip \
    && mv autopsy/autopsy*/* autopsy/. \
    && rm autopsy.zip \
    && RELEASE_PATH=`curl -sL https://github.com/sleuthkit/sleuthkit/releases/latest \
        | grep -Eo 'href=".*\.deb' \
        | grep -v archive \
        | head -1 \
        | cut -d '"' -f 2` \
    && curl -L https://github.com/${RELEASE_PATH} > tsk_java.deb \
    && dpkg -i tsk_java.deb \
        || apt-get install -fy \
    && cd /opt \
    && unzip -P AcceptEULA jdk*.zip \
    && rm jdk*.zip \
    && cd /opt/autopsy*/ \
    && sh ./unix_setup.sh

# cd /opt && curl -L -H 'Cookie: oraclelicense=accept-securebackup-cookie' https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz > jdk.tar.gz && tar xf jdk.tar.gz && rm jdk.tar.gz && cd jdk* && \

ENTRYPOINT ["autopsy"]
