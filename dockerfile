FROM alpine:latest
MAINTAINER beardyjay <jay@beardyjay.co.uk>

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

RUN git clone https://github.com/n7902/dnsrecon.git \
    && cd dnsrecon \  
    && pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["/usr/share/dnsrecon/dnsrecon.py"]
