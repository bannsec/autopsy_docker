FROM ubuntu:bionic

ARG DEBIAN_FRONTEND=noninteractive

COPY --from=bannsec/autopwn-stage-j8 /tmp/jdk* /opt/.

RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y curl x11-apps xauth unzip testdisk wget dnsutils libboost-dev libboost-all-dev x11-utils x11proto-core-dev x11proto-dev xkb-data xorg-sgml-doctools xtrans-dev openjfx && \
    RELEASE_PATH=`curl -sL https://github.com/sleuthkit/autopsy/releases/latest | grep -Eo 'href=".*.zip' | grep -v archive | head -1 | cut -d '"' -f 2` && \
    mkdir -p /opt && cd /opt && curl -L https://github.com/${RELEASE_PATH} > autopsy.zip && \
    unzip autopsy.zip && rm autopsy.zip && \
    RELEASE_PATH=`curl -sL https://github.com/sleuthkit/sleuthkit/releases/latest | grep -Eo 'href=".*\.deb' | grep -v archive | head -1 | cut -d '"' -f 2` && \
    curl -L https://github.com/${RELEASE_PATH} > tsk_java.deb && \
    dpkg -i tsk_java.deb || apt-get install -fy && \
    cd /opt && unzip -P AcceptEULA jdk*.zip && rm jdk*.zip && cd jdk* && \
        export JAVA_HOME=$PWD && echo export JAVA_HOME=$JAVA_HOME >> ~/.bashrc && export PATH=$JAVA_HOME/bin:$PATH && echo export PATH=$JAVA_HOME/bin:\$PATH >> ~/.bashrc && \
    cd /opt/autopsy*/ && sh ./unix_setup.sh && \
    cd bin && echo export PATH=$PWD:\$PATH >> ~/.bashrc

# cd /opt && curl -L -H 'Cookie: oraclelicense=accept-securebackup-cookie' https://download.oracle.com/otn-pub/java/jdk/8u201-b09/42970487e3af4f5aa5bca3f542482c60/jdk-8u201-linux-x64.tar.gz > jdk.tar.gz && tar xf jdk.tar.gz && rm jdk.tar.gz && cd jdk* && \

CMD ["/bin/bash"]
