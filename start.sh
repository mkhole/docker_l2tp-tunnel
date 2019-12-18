#!/bin/sh

# Create xl2tpd config
cat > /etc/xl2tpd/xl2tpd.conf <<EOF
[global]
port = 1701
[lns default]
ip range = 192.168.42.10-192.168.42.50
local ip = 192.168.42.1
require chap = yes
refuse pap = yes
require authentication = yes
name = l2tpd
pppoptfile = /etc/ppp/options.xl2tpd
length bit = yes
EOF

# Set xl2tpd options
cat > /etc/ppp/options.xl2tpd <<EOF
ipcp-accept-local
ipcp-accept-remote
ms-dns 8.8.8.8
ms-dns 8.8.4.4
noccp
auth
idle 1800
mtu 1410
mru 1410
nodefaultroute
debug
proxyarp
connect-delay 5000
EOF

# Create user credentials
IFS=';'
> /etc/ppp/cap-secrets
for i in $ENV_USER_LIST
do
	USER=`echo $i | awk -F, '{print $1}'`
	PASS=`echo $i | awk -F, '{print $2}'`
	echo -e "${USER}\t*\t${PASS}\t*" >> /etc/ppp/chap-secrets
done
IFS=

/usr/sbin/xl2tpd -D -c /etc/xl2tpd/xl2tpd.conf

echo "Entry point"
exec "$@"
