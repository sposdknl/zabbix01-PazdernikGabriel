#!/usr/bin/env bash
set -e

# Aktualizace balíčků
sudo apt-get update -y
sudo apt-get install -y wget gnupg2 lsb-release

# Přidání Zabbix repozitáře
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu$(lsb_release -rs)_all.deb
sudo dpkg -i zabbix-release_7.0-1+ubuntu$(lsb_release -rs)_all.deb
sudo apt-get update -y

# Instalace agenta
sudo apt-get install -y zabbix-agent2
