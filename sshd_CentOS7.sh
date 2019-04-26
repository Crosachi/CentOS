#!/bin/bash

# SSHD setting script
#For CentOS7
# https://github.com/Crosachi/

#RCS
yum install rcs -y
mkdir /etc/ssh/RCS
ci -l /etc/ssh/sshd_config << EOS
.
EOS

#PermitRootLogin yes -> PermitRootLogin no
sed -i -e "s/#PermitRootLogin yes$/PermitRootLogin no/g" /etc/ssh/sshd_config

#PermitEmptyPasswords no -> PermitEmptyPasswords no
sed -i -e "s/#PermitEmptyPasswords no$/PermitEmptyPasswords no/g" /etc/ssh/sshd_config

#LoginGraceTime 2m -> LoginGraceTime 30
sed -i -e "s/^#LoginGraceTime 2m$/LoginGraceTime 30s/g" /etc/ssh/sshd_config

#MaxAuthTries 6 -> MaxAuthTries 3
sed -i -e "s/^#MaxAuthTries 6$/MaxAuthTries 3/g" /etc/ssh/sshd_config

#AllowTcpForwarding yes -> AllowTcpForwarding no
sed -i -e "s/^#AllowTcpForwarding yes$/AllowTcpForwarding no/g" /etc/ssh/sshd_config

sed -i -e "/Ciphers aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,arcfour/d" /etc/ssh/sshd_config
echo "Ciphers aes128-ctr,aes192-ctr,aes256-ctr,arcfour256,arcfour128,arcfour" >> /etc/ssh/sshd_config
sed -i -e "/MACs hmac-sha1,umac-64@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-ripemd160,hmac-ripemd160@openssh.com/d" /etc/ssh/sshd_config
echo "MACs hmac-sha1,umac-64@openssh.com,hmac-sha2-256,hmac-sha2-512,hmac-ripemd160,hmac-ripemd160@openssh.com" >> /etc/ssh/sshd_config

#restart sshd
systemctl restart sshd
systemctl status sshd

#show diff config file
rcsdiff -r1.1 /etc/ssh/sshd_config
