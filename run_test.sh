#!/usr/bin/env bash

# build and run image
docker build . --tag=debian10ssh
docker rm -f debian10
docker run -d --rm -p 22022:22 --name=debian10 debian10ssh

# generate and copy key to running container
ssh-keygen -P '' -f rsa_key -t rsa

# deploy key to container and setup permissions
docker exec debian10 mkdir -p /home/ansible/.ssh
docker cp rsa_key.pub debian10:/home/ansible/.ssh/authorized_keys
docker exec debian10 chmod 600 /home/ansible/.ssh/authorized_keys
docker exec debian10 chown ansible:ansible /home/ansible/.ssh/authorized_keys

# ansible-galaxy install robertdebock.dns
# ansible-playbook -f playbook.yml
