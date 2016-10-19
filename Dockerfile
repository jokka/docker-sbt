#
# Static web image (node, Git, AWS CLI) based on Alpine
#

FROM 1science/java:oracle-jdk-8
MAINTAINER Jovan Erčić <jovan.ercic@gmail.com>

RUN apk update

RUN apk add nodejs

RUN apk add git

RUN mkdir -p /aws && \
    apk -Uuv add groff less python py-pip && \
    pip install awscli && \
    apk --purge -v del py-pip

RUN rm -f /var/cache/apk/*

WORKDIR /app
