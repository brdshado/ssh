# 🚀 VPS Auto SSH Login Setup

This repository contains a quick setup script to add my local computer's SSH key to any new VPS, allowing me to log in instantly without a password.

## ⚡ Quick Install

When you get a new VPS, log into it using the provider's default password, then run this single command to inject your SSH key:

```bash
bash <(curl -s [https://raw.githubusercontent.com/brdshado/ssh/main/ssh-setup.sh](https://raw.githubusercontent.com/brdshado/ssh/main/ssh-setup.sh))
