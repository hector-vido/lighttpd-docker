FROM alpine

# The steps above is just to create a single layer
# Fell free to use the COPY statements
COPY lighttpd-foreground /usr/local/bin/lighttpd-foreground
COPY lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY index.html /var/www/html/localhost/htdocs/index.html

RUN apk add lighttpd \
#	&& wget https://raw.githubusercontent.com/hector-vido/lighttpd-docker/master/lighttpd-foreground -O /usr/local/bin/lighttpd-foreground \
#	&& wget https://raw.githubusercontent.com/hector-vido/lighttpd-docker/master/lighttpd.conf -O /etc/lighttpd/lighttpd.conf \
#	&& wget https://raw.githubusercontent.com/hector-vido/lighttpd-docker/master/index.html -O /var/www/localhost/htdocs/index.html \
	&& mkdir -p /var/lib/lighttpd/cache/compress \
	&& chown -R lighttpd: /var/lib/lighttpd \
	&& chmod +x /usr/local/bin/lighttpd-foreground

USER lighttpd

ENTRYPOINT ["lighttpd-foreground"]
