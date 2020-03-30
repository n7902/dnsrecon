FROM alpine:latest
MAINTAINER meridian security

RUN apk update 


RUN apk add --update \
  git \
  python \
  py-pip \
  gcc \
  libxml2-dev \
  libxslt-dev \
  libc-dev \
  python2-dev \
  python3 \
  && rm -rf /var/cache/apk/*

# Install dnsrecon from git along with deps
WORKDIR /usr/share

RUN wget -O dnspython.tgz http://www.dnspython.org/kits3/1.10.0/dnspython3-1.10.0.tar.gz \
&& tar xvf dnspython.tgz \
&& cd dnspython3-1.10.0 \
&& python3 setup.py build \
&& su -c "python3 setup.py install" \
&& cd /usr/share \
&& pip install lxml \ 
&& pip2 install lxml \
&& git clone https://github.com/n7902/dnsrecon.git \
    && cd dnsrecon \  
    && pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["/usr/share/dnsrecon/dnsrecon.py"]

