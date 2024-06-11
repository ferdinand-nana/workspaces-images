#!/bin/bash

STS4_VER="4.22.1"
ECLIPSE_VER="e4.31"

cd /tmp
wget -q -O eclipse.tar.gz "https://cdn.spring.io/spring-tools/release/STS4/${STS4_VER}.RELEASE/dist/${ECLIPSE_VER}/spring-tool-suite-4-${STS4_VER}.RELEASE-${ECLIPSE_VER}.0-linux.gtk.$(arch).tar.gz"
tar -xzf eclipse.tar.gz  --strip-components=1 -C /opt/eclipse

ECLIPSE_ICON="/opt/sts-${STS4_VER}.RELEASE/plugins/$(ls /opt/${STS4_VER}/plugins/ | grep -m 1 org.eclipse.platform_)/eclipse128.png"
sed -i "s#eclipse128.png#${ECLIPSE_ICON}#" $INST_SCRIPTS/eclipse/eclipse.desktop
cp $INST_SCRIPTS/eclipse/eclipse.desktop $HOME/Desktop/
cp $INST_SCRIPTS/eclipse/eclipse.desktop /usr/share/applications/
