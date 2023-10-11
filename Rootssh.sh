#!/bin/bash
echo "PermitRootLogin yes" | tee -a /etc/ssh/sshd_config
service sshd restart
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target
echo "Don't forget set password for root"