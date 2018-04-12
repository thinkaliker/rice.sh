#!/bin/bash
GRN='\033[0;32m'
NC='\033[0m'

echo -e "${GRN}[quick update (qup)]${NC}"
echo -e "${GRN}[updating repositories]${NC}"
sudo apt-get update
echo -e "${GRN}[upgrading packages]${NC}"
sudo apt-get upgrade -y
echo -e "${GRN}[dist-upgrade packages]${NC}"
sudo apt-get dist-upgrade -y
echo -e "${GRN}[autoremove packages]${NC}"
sudo apt-get autoremove -y
echo -e "${GRN}[quick update complete]${NC}"