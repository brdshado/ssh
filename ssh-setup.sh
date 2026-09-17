#!/bin/bash

# Create the .ssh directory and set correct permissions
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Append your public key to the authorized_keys file
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOS2y3d1Ef7ow3NZNlnAbGjxvqdcoj/9JehFq3SIg1af brdshado@gmail.com" >> ~/.ssh/authorized_keys

# Secure the authorized_keys file
chmod 600 ~/.ssh/authorized_keys

echo "Public key successfully added! You can now log in without a password."
