#!/bin/bash

# Benutzernamen abfragen
read -p "Bitte geben Sie den gewünschten Benutzernamen ein: " username

# Zufälliges Passwort generieren (hier 16 Zeichen lang)
password=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)

# Zufälliger SSH-Port
random_port=$(( 1024 + $RANDOM % (65535 - 1024) ))

# Neuen Benutzer erstellen und Passwort setzen
useradd -m -p $(openssl passwd -crypt $password) $username

# SSH-Zugang für den neuen Benutzer erlauben
usermod -aG sudo $username

# SSH-Zugang für root deaktivieren
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

# SSH-Port ändern
sed -i "s/Port 22/Port $random_port/g" /etc/ssh/sshd_config

# Firewall konfigurieren (Beispiel für iptables)
iptables -A INPUT -p tcp --dport $random_port -j ACCEPT

# SSH-Dienst neu starten
systemctl restart sshd

# Ausgabe der Benutzerdaten und des Ports
echo "Neuer Benutzer: $username"
echo "Passwort: $password"
echo "Neuer SSH-Port: $random_port"
echo "Bitte merken Sie sich das Passwort!"
