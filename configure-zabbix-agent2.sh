#!/usr/bin/env bash
set -e

# Parametry
ZABBIX_SERVER="127.0.0.1"        # Změň na IP tvého Zabbix serveru
HOSTNAME="ubuntu-pazdernik"
SERVICE_NAME="zabbix-pazdernik"
CONFIG_FILE="/etc/zabbix/zabbix_agent2.conf"

# Kontrola instalace
if ! dpkg -l | grep -q zabbix-agent2; then
  echo "Zabbix Agent 2 není nainstalován. Spusť install-zabbix-agent2.sh nejdříve."
  exit 1
fi

# Připravíme vlastní službu
sudo cp /lib/systemd/system/zabbix-agent2.service /etc/systemd/system/${SERVICE_NAME}.service

# Upravení služby (Description a správný ExecStart)
sudo sed -i "s/^Description=.*/Description=Zabbix Agent 2 - Pazdernik/" /etc/systemd/system/${SERVICE_NAME}.service
sudo sed -i "s|ExecStart=.*|ExecStart=/usr/sbin/zabbix_agent2 -c ${CONFIG_FILE}|" /etc/systemd/system/${SERVICE_NAME}.service

# Konfigurace agenta
sudo sed -i "s/^Server=.*/Server=${ZABBIX_SERVER}/" ${CONFIG_FILE}
sudo sed -i "s/^ServerActive=.*/ServerActive=${ZABBIX_SERVER}/" ${CONFIG_FILE}
sudo sed -i "s/^Hostname=.*/Hostname=${HOSTNAME}/" ${CONFIG_FILE}

# Povolení a spuštění nové služby
sudo systemctl daemon-reload
sudo systemctl enable ${SERVICE_NAME}
sudo systemctl restart ${SERVICE_NAME}

echo "Zabbix Agent 2 '${HOSTNAME}' byl nakonfigurován a spuštěn jako služba '${SERVICE_NAME}'."
