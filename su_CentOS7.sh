#!/bin/bash

# su setting script
#For CentOS7
# https://github.com/Crosachi/

#RCS
yum install rcs -y
mkdir /etc/pam.d/RCS
ci -l /etc/pam.d/su << EOS
.
EOS

sed -i -e "s/^#auth.*pam_wheel.so use_uid$/auth           required        pam_wheel.so use_uid/g" /etc/pam.d/su

#show diff config file
rcsdiff -r1.1 /etc/pam.d/su
