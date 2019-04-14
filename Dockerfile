FROM ubuntu:bionic

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y curl x11-apps xauth unzip testdisk wget dnsutils libboost-dev libboost-all-dev x11-utils x11proto-core-dev x11proto-dev xkb-data xorg-sgml-doctools xtrans-dev openjfx && \
    mkdir -p /opt && cd /opt && curl -L $(curl -s https://api.github.com/repos/sleuthkit/autopsy/releases/latest | grep 'https://github.com/sleuthkit/autopsy/releases/download.*zip"' | cut -d : -f 2,3 | tr -d '"') > autopsy.zip && \
    unzip autopsy.zip && rm autopsy.zip && \
    curl -L $(curl -s https://api.github.com/repos/sleuthkit/sleuthkit/releases/latest | grep 'https://github.com/sleuthkit/sleuthkit/releases/download.*deb"' | cut -d : -f 2,3 | tr -d '"') > tsk_java.deb && \
    dpkg -i tsk_java.deb || apt-get install -fy && \
    cd /opt && curl -L -H 'Cookie: oraclelicense=accept-securebackup-cookie' https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz > jdk.tar.gz && tar xf jdk.tar.gz && rm jdk.tar.gz && cd jdk* && \
        export JAVA_HOME=$PWD && echo export JAVA_HOME=$JAVA_HOME >> ~/.bashrc && export PATH=$JAVA_HOME/bin:$PATH && echo export PATH=$JAVA_HOME/bin:\$PATH >> ~/.bashrc && \
    cd /opt/autopsy*/ && sh ./unix_setup.sh && \
    cd bin && echo export PATH=$PWD:\$PATH >> ~/.bashrc

CMD ["/bin/bash"]
