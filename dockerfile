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
&& wget -O https://files.pythonhosted.org/packages/0c/13/7cbb180b52201c07c796243eeff4c256b053656da5cfe3916c3f5b57b3a0/netaddr-0.7.19.tar.gz \ 
&& tar xvf netaddr* \
&& cd netaddr* \
&& python3 setup.py build \ 
&& cd /usr/share \
&& pip install lxml \ 
&& pip2 install lxml \
&& git clone https://github.com/n7902/dnsrecon.git \
    && cd dnsrecon \  
    && pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["/usr/share/dnsrecon/dnsrecon.py"]

