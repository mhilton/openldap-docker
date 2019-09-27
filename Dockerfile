ARG BASE=ubuntu
FROM $BASE
RUN apt-get -q update && \
	echo "slapd slapd/no_configuration boolean true" | debconf-set-selections && \
	DEBIAN_FRONTEND=noninteractive apt-get -q install -y ldap-utils slapd && \
	apt-get -q clean
VOLUME /srv/ldap/data
CMD ["/srv/ldap/bin/init"]
ENV DB_SUFFIX=dc=example,dc=com LOG_LEVEL=256 DB_ROOT_DN= DB_ROOT_PASSWORD=
COPY init  /srv/ldap/bin/
COPY *.ldif *.sh /srv/ldap/init/cn=config/
