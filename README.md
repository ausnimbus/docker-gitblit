# Gitblit

This is a Docker image of Gitblit (http://gitblit.com/) based on `java:jre`
designed to be run on AusNimbus/OpenShift

This is a community maintained AusNimbus image

## Usage

```
oc create -f openshift/gitblit-template.yaml
```

Gitblit interface should be available at
(user/password: `admin`/`admin`)

By default it uses a persistent data volume for persistence.

daemonPort and sshPort are disabled as they are not currently supported by the
OpenShift router

### Configuration

You can configure the instance by editing files
in directory /opt/gitblit-data inside the container

By default the JVM is started with options `-server -Xmx768m`.
You can override this default using `JAVA_OPTS` environment
variable.

### Credits

This image is forked from https://github.com/jacekkow/docker-gitblit
