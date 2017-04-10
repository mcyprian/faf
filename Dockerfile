FROM fedora:latest

MAINTAINER Michal Cyprian <m.cyprian@gmail.com>

EXPOSE 5000

ENV PYTHONIOENCODING=UTF-8 \
    LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    PIP_NO_CACHE_DIR=off

RUN INSTALL_PKGS="yum python2-rpm python2-devel python2-psycopg2 gcc redhat-rpm-config openssl-devel" && \
    dnf install -y $INSTALL_PKGS && \
    dnf clean all && \
    mkdir -p /opt/app-root && \
    useradd -u 1001 -r -g 0 -d ${HOME} -s /sbin/nologin \
-c "Default Application User" default && \
    chown -R 1001:0 /opt/app-root && chmod -R og+rwx /opt/app-root

COPY . /opt/app-root/

RUN pip install --no-cache-dir -r /opt/app-root/requirements.txt

USER 1001

WORKDIR /opt/app-root/src/webfaf/

CMD ["python", "webfaf_main.py"]

