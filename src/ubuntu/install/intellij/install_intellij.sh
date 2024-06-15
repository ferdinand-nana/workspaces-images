#!/usr/bin/env bash
set -ex

# Initialization
IDEA_VERSION=2024.1
IDEA_BUILD=2024.1.2
idea_local_dir=.IntelliJIdea${IDEA_VERSION}

echo "Downloading IntelliJ..."
cd /tmp
wget -q -O installer.tar.gz "https://download.jetbrains.com/idea/ideaIU-${IDEA_BUILD}.tar.gz"

echo "Installing Intellij..."
mkdir -p /opt/idea
cp "/tmp/installer.tar.gz" /opt/idea/installer.tar.gz

cd /opt/idea
echo "Untar IntelliJ IDEA Pro ${IDEA_BUILD} ..."
tar --strip-components=1 -xzf installer.tar.gz
rm installer.tar.gz

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