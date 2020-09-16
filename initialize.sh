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

echo "Install fish"
# Keep in mind that the owner of the key may distribute updates, packages and repositories that your system will trust (more information).
echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_10/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_10/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells:fish:release:3.gpg > /dev/null
sudo apt update
sudo apt install fish
chsh -s `which fish`

echo "Install snap"
sudo apt install snapd
sudo snap install hello-world
hello-world

echo "Install dotnet sdk"
sudo snap install dotnet-sdk --channel=5.0/beta --classic
sudo snap alias dotnet-sdk.dotnet dotnet
sudo ln -sv /snap/dotnet-sdk/current/dotnet /usr/local/bin/dotnet

echo "Install GIT"
sudo apt install git-all