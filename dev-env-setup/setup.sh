#!/usr/bin/env bash

function install_docker () {
    # Update the apt package index
    sudo apt-get update -q
    # Install packages to allow apt to use a repository over HTTPS
    sudo apt-get install -qy \
        apt-transport-https \
        ca-certificates \
        curl \
        software-properties-common
    # Add Docker’s official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    # Add apt stable Docker repository
    sudo add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable"
    # Update the apt package index
    sudo apt-get update -q
    # Install the latest version of Docker CE
    sudo apt-get install -y docker-ce
    # Create the docker group
    sudo groupadd docker
    # Add your user to the docker group
    sudo usermod -aG docker $USER
}

function generate_ssh_key () {
    mkdir ~/.ssh
    read -p "Enter your email:" email
    ssh-keygen -t rsa -C $email -b 4096 -f ~/.ssh/id_rsa 
}

echo "Step 1. get Docker"

echo "Do you wish to install Docker?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) install_docker; break;;
        No ) break;;
    esac
done

echo "Step 2. generate SSH key"

echo "Do you wish to generate a standard new SSH key?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) generate_ssh_key; break;;
        No ) break;;
    esac
done
cp -r ~/.ssh .

echo "Done."
echo "Here is your public key:"
cat .ssh/id_rsa.pub
