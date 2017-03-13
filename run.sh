#!/bin/bash

if [ ! -f /opt/gitblit-data/gitblit.properties ]; then
	cp -Rf /opt/gitblit-data-initial/* /opt/gitblit-data/
fi

if [ -z "$JAVA_OPTS" ]; then
	JAVA_OPTS="-server -Xmx768m"
fi

chown -Rf gitblit:gitblit /opt/gitblit-data

exec java $JAVA_OPTS -Djava.awt.headless=true -jar /opt/gitblit/gitblit.jar --baseFolder /opt/gitblit-data
