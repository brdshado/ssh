#!/bin/bash

# Define colors for a professional look
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

TARGET_DIR="$HOME/.ssh"
AUTH_KEYS="$TARGET_DIR/authorized_keys"

# ⚠️ PASTE YOUR NEW PUBLIC KEY INSIDE THE QUOTES BELOW:
MY_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAYOUR_NEW_KEY_HERE... brdshado@gmail.com"

# 🧹 Your old lost key (stored here so the script can clean it up for you)
OLD_KEY="ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOS2y3d1Ef7ow3NZNlnAbGjxvqdcoj/9JehFq3SIg1af brdshado@gmail.com"

# Check if the NEW key is currently installed
STATUS="${RED}NOT INSTALLED${NC}"
if [ -f "$AUTH_KEYS" ] && grep -Fq "$MY_KEY" "$AUTH_KEYS"; then
    STATUS="${GREEN}INSTALLED & ACTIVE${NC}"
fi

clear
echo -e "${CYAN}====================================================${NC}"
echo -e "             Brdshado SSH Access Manager            "
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
        echo -e "\n${YELLOW}Installing new key and removing old one...${NC}"
        mkdir -p "$TARGET_DIR" && chmod 700 "$TARGET_DIR"
        touch "$AUTH_KEYS" && chmod 600 "$AUTH_KEYS"
        
        # Purge the old lost key and any duplicates of the new key
        sed -i "\#$OLD_KEY#d" "$AUTH_KEYS"
        sed -i "\#$MY_KEY#d" "$AUTH_KEYS"
        
        # Append the new key securely
        echo "$MY_KEY" >> "$AUTH_KEYS"
        echo -e "${GREEN}✅ New key installed successfully! Old key purged.${NC}\n"
        ;;
    2)
        echo -e "\n${YELLOW}Removing keys...${NC}"
        if [ -f "$AUTH_KEYS" ]; then
            # Remove both keys inline safely
            sed -i "\#$OLD_KEY#d" "$AUTH_KEYS"
            sed -i "\#$MY_KEY#d" "$AUTH_KEYS"
            echo -e "${GREEN}🗑️ All access keys removed successfully!${NC}\n"
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
