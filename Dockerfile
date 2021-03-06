FROM openjdk:jre
MAINTAINER Andrew Lau <support@ausnimbus.com.au>

ENV GITBLIT_VERSION 1.8.0

RUN apt-get update \
	&& apt-get dist-upgrade -y \
	&& apt-get install -y git-core sudo wget \
	&& apt-get clean

# Install Gitblit
WORKDIR /opt
RUN wget -O /tmp/gitblit.tar.gz http://dl.bintray.com/gitblit/releases/gitblit-${GITBLIT_VERSION}.tar.gz \
	&& tar xzf /tmp/gitblit.tar.gz \
	&& rm -f /tmp/gitblit.tar.gz \
	&& ln -s gitblit-${GITBLIT_VERSION} gitblit \
	&& mv gitblit/data gitblit-data-initial \
	&& mkdir gitblit-data
RUN groupadd -r -g 500 gitblit \
	&& useradd -r -d /opt/gitblit-data -u 500 -g 500 gitblit \
	&& chown -Rf gitblit:gitblit /opt/gitblit-*

# Adjust the default Gitblit settings to bind to 8080, 8443 and allow RPC administration.
RUN echo "server.httpPort=8080" >> gitblit-data-initial/gitblit.properties \
	&& echo "server.httpsPort=8443" >> gitblit-data-initial/gitblit.properties \
	&& echo "web.enableRpcManagement=true" >> gitblit-data-initial/gitblit.properties \
	&& echo "web.enableRpcAdministration=true" >> gitblit-data-initial/gitblit.properties \
	&& echo "git.daemonPort=0" >> gitblit-data-initial/gitblit.properties \
	&& echo "git.sshPort=0" >> gitblit-data-initial/gitblit.properties


# Setup the Docker container environment and run Gitblit
VOLUME /opt/gitblit-data
EXPOSE 8080 8443 9418 29418

USER gitblit
WORKDIR /opt/gitblit
COPY run.sh /run.sh
CMD /run.sh
