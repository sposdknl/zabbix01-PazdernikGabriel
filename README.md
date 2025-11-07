Projekt: Vagrant + Zabbix Agent 2



\- Vagrant VM: Ubuntu Jammy64

\- Zabbix Agent 2 (verze 7.0 LTS) nainstalován a spuštěn

\- Auto-registrace na Zabbix server: enceladus.pfsense.cz

\- Hostname: ubuntu-pazdernik

\- HostMetadata: SPOS



Použití:

1\. Spustit VM: vagrant up --provision

2\. Připojit se do VM: vagrant ssh

3\. Zkontrolovat agenta: sudo systemctl status zabbix-pazdernik

4\. Host se objeví ve Zabbix frontend

5. Export hosta: Configuration → Hosts → Host → Export → JSON/YAML/XML



Poznámky:

\- SSH port: 22222

\- HTTP port: 8080

\- Nepřidávat soukromé klíče do repozitáře

