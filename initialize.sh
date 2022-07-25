#!/bin/bash
cat /etc/debian_version
lsb_release -a
echo "Prepare docker"
curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
sudo usermod -aG docker keke

sudo tee /etc/docker/daemon.json <<-'EOF'
{
    "registry-mirrors": ["https://50t8xpr9.mirror.aliyuncs.com"]
}
EOF

echo "Set mirrors"
sudo cp -a /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sed -i "s@http://packages.deepin.com/deepin@https://mirrors.huaweicloud.com/deepin@g" /etc/apt/sources.list
sudo apt-get update

#echo "Set proxy"
#export http_proxy=http://127.0.0.1:7890
#export https_proxy=http://127.0.0.1:7891
# sudo -E balabala
#sudo snap set system proxy.https=socks5://127.0.0.1:7890
#sudo snap set system proxy.http=socks5://127.0.0.1:7891


echo "Install fish"
# Keep in mind that the owner of the key may distribute updates, packages and repositories that your system will trust (more information).
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells:fish:release:3.gpg > /dev/null
sudo apt update
sudo apt install fish
chsh -s `which fish`

# echo "Install snap"
# sudo apt install snapd
# sudo snap install hello-world
# hello-world

echo "Install dotnet sdk"
# sudo snap install dotnet-sdk --classic
# sudo snap alias dotnet-sdk.dotnet dotnet
# sudo ln -sv /snap/dotnet-sdk/current/dotnet /usr/local/bin/dotnet
# sudo touch /etc/profile.d/env.sh
# sudo tee /etc/profile.d/env.sh <<-'EOF'
# export PATH="$PATH:$HOME/.dotnet/tools"
# export DOTNET_ROOT=/snap/dotnet-sdk/current
# export MSBuildSDKsPath=$DOTNET_ROOT/sdk/$(${DOTNET_ROOT}/dotnet --version)/Sdks
# export PATH="${PATH}:${DOTNET_ROOT}"
# EOF

wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt-get update; \
  sudo apt-get install -y apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-6.0

echo "Install GIT"
sudo apt install git-all

# echo "Install Node"
# sudo snap install node --channel=14/stable --classic

# echo "Set en for SU"
# sudo visudo

# sudo npm config set scripts-prepend-node-path auto

sudo apt install remmina

# share folder
sudo apt install cifs-utils
# openwrt share
echo //192.168.1.10/share /mnt/share cifs vers=3.0,credentials=/home/KEKE/Documents/smbCredentialsShare >> /etc/fstab

# htpc d
echo //192.168.1.100/D /mnt/d cifs vers=3.0,credentials=/home/KEKE/Documents/smbLocalD,file_mode=0777,dir_mode=0777,uid=$USER,gid=$USER >> /etc/fstab
