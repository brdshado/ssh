#!/bin/bash

# Define colors for a professional look
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

MY_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOS2y3d1Ef7ow3NZNlnAbGjxvqdcoj/9JehFq3SIg1af brdshado@gmail.com"

# Check if the key is currently installed
STATUS="${RED}NOT INSTALLED${NC}"
if [ -f ~/.ssh/authorized_keys ] && grep -q "$MY_KEY" ~/.ssh/authorized_keys; then
    STATUS="${GREEN}INSTALLED & ACTIVE${NC}"
fi

clear
echo -e "${CYAN}====================================================${NC}"
echo -e "           Brdshado SSH Access Manager              "
echo -e "${CYAN}====================================================${NC}"
echo -e "This script controls my SSH access to your server."
echo -e "Remove access immediately after my work is complete."
echo -e "----------------------------------------------------"
echo -e "Current Status: $STATUS"
echo -e "----------------------------------------------------"
echo ""
echo -e "${GREEN}1${NC} | Install SSH Key (Grant Access)"
echo -e "${RED}2${NC} | Remove SSH Key (Revoke Access)"
echo -e "3 | Exit"
echo ""
read -p "Select an option [1-3]: " choice

case $choice in
    1)
        echo -e "\n${YELLOW}Installing key...${NC}"
        mkdir -p ~/.ssh
        chmod 700 ~/.ssh
        touch ~/.ssh/authorized_keys
        
        # Remove just in case to prevent duplicate entries, then add
        grep -v "$MY_KEY" ~/.ssh/authorized_keys > ~/.ssh/authorized_keys.tmp
        mv ~/.ssh/authorized_keys.tmp ~/.ssh/authorized_keys
        
        echo "$MY_KEY" >> ~/.ssh/authorized_keys
        chmod 600 ~/.ssh/authorized_keys
        
        echo -e "${GREEN}✅ Key installed successfully! I can now log in.${NC}\n"
        ;;
    2)
        echo -e "\n${YELLOW}Removing key...${NC}"
        if [ -f ~/.ssh/authorized_keys ]; then
            grep -v "$MY_KEY" ~/.ssh/authorized_keys > ~/.ssh/authorized_keys.tmp
            mv ~/.ssh/authorized_keys.tmp ~/.ssh/authorized_keys
            chmod 600 ~/.ssh/authorized_keys
            echo -e "${GREEN}🗑️ Key removed successfully! My access is revoked.${NC}\n"
        else
            echo -e "${RED}No SSH keys found on this server.${NC}\n"
        fi
        ;;
    3)
        echo -e "\nExiting without making changes.\n"
        exit 0
        ;;
    *)
        echo -e "\n${RED}❌ Invalid selection. Exiting.${NC}\n"
        exit 1
        ;;
esac
