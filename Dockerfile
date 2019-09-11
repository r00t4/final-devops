FROM centos
RUN yum update
RUN yum install git -y
RUN yum install autoconf -y
RUN yum install automake -y
RUN yum install libtool -y
RUN yum install make -y
RUN yum install -y openssl-devel
RUN su - && yum install sudo -y

RUN git clone https://github.com/Netflix/dynomite.git
RUN cd dynomite
RUN ls -la
RUN cd dynomite && git fetch && git fetch --tags
RUN cd dynomite && git checkout tags/v0.6.15
RUN cd dynomite && autoreconf -fvi
RUN cd dynomite && ./configure --enable-debug=log
RUN cd dynomite && make
RUN cd dynomite && sudo make install
RUN cd dynomite && sudo mkdir /etc/dynomite

CMD ['/usr/local/bin/dynomite -d -c $DYNOMITE_CONF -p /var/run/dynomite.pid --output=/var/log/dynomite.log']
