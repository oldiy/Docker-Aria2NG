FROM alpine:edge

MAINTAINER oD <oldiy@163.com>

RUN apk update && \
	apk add --no-cache --update bash && \
	mkdir -p /conf && \
	mkdir -p /conf-copy && \
	mkdir -p /data && \
	apk add --no-cache --update aria2 && \
	apk add git && \
	git clone https://github.com/ziahamza/webui-aria2 /aria2-webui && \
	rm /aria2-webui/.git* -rf && \
	apk del git && \
	mkdir -p /aria2ng && \
	cd /aria2ng && \
	apk add --no-cache --update wget && \
	wget -N --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/1.0.0/AriaNg-1.0.0.zip && unzip AriaNg-1.0.0.zip && rm -rf AriaNg-1.0.0.zip  && \
	apk del wget && \
	apk add --update darkhttpd

ADD files/start.sh /conf-copy/start.sh
ADD files/aria2.conf /conf-copy/aria2.conf
ADD files/on-complete.sh /conf-copy/on-complete.sh

RUN chmod +x /conf-copy/start.sh

WORKDIR /
VOLUME ["/data"]
VOLUME ["/conf"]
ENV SECRET=oldiy
EXPOSE 6800
EXPOSE 8080
EXPOSE 80
EXPOSE 81

CMD ["/conf-copy/start.sh"]
