FROM alpine
MAINTAINER Konstantin Jakobi <konstantin.jakobi@gmail.com>

RUN apk add --no-cache bash mysql-client \
 && mkdir /backup \
 && mkdir /log

COPY run.sh backup.sh /
CMD /run.sh
