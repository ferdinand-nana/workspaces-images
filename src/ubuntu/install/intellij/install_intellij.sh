#!/usr/bin/env bash
set -ex

# Initialization
IDEA_VERSION=2024.1
IDEA_BUILD=2024.1.2
idea_local_dir=.IntelliJIdea${IDEA_VERSION}

# Install Intellij
# mkdir -p /opt/idea
# echo "Copying IntelliJ IDEA Ultimate ${IDEA_BUILD} ..." \
#     && cp $INST_SCRIPTS/intellij/ideaIU-$IDEA_BUILD.tar.gz /opt/idea/installer.tgz \
#     && echo "Untar IntelliJ IDEA Pro ${IDEA_BUILD} ..." \
#     && tar --strip-components=1 -xzf installer.tgz \
#     && rm installer.tgz

# Desktop icon
echo "[Desktop Entry]
Version=13.0
Name=IntelliJ
Type=Application
Exec=/opt/idea/bin/idea.sh
Terminal=false
Icon=/opt/idea/bin/idea.png
Icon[en_US]=/opt/idea/bin/idea.png
Name[en_US]=IntelliJ" > /usr/share/applications/intellij.desktop

cp /usr/share/applications/intellij.desktop $HOME/Desktop
chmod +x $HOME/Desktop/intellij.desktop
chown 1000:1000 $HOME/Desktop/intellij.desktop

mkdir -p $HOME/.Idea \
    && ln -sf $HOME/.Idea $HOME/$idea_local_dir


# Cleanup for app layer
chown -R 1000:0 $HOME
find /usr/share/ -name "icon-theme.cache" -exec rm -f {} \;
if [ -z ${SKIP_CLEAN+x} ]; then
  apt-get autoclean
  rm -rf \
    /var/lib/apt/lists/* \
    /var/tmp/* \
    /tmp/*
fi