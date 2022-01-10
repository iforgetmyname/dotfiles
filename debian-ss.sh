#!/usr/bin/env bash
### Debian Repos
cat << EOF > /etc/apt/sources.list.d/official.list
deb http://deb.debian.org/debian/ bullseye main contrib non-free
#deb-src http://deb.debian.org/debian/ bullseye main contrib non-free

deb http://deb.debian.org/debian/ bullseye-updates main contrib non-free
#deb-src http://deb.debian.org/debian/ bullseye-updates main contrib non-free

deb http://deb.debian.org/debian/ bullseye-backports main contrib non-free
#deb-src http://deb.debian.org/debian/ bullseye-backports main contrib non-free

deb http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
#deb-src http://deb.debian.org/debian-security/ bullseye-security main contrib non-free
EOF

### Limits
cat << EOF >> /etc/security/limits.conf
*                soft    nofile          51200
*                hard    nofile          51200
EOF

### Kernel Parameters
cat << EOF >> /etc/sysctl.conf
fs.file-max = 51200

net.core.default_qdisc = fq
net.ipv4.tcp_congestion_control = bbr

net.core.netdev_max_backlog = 65536
net.ipv4.tcp_max_syn_backlog = 65536
net.ipv4.tcp_max_tw_buckets = 65536
net.core.optmem_max = 65536
net.core.somaxconn = 16384

net.core.rmem_default = 1048576
net.core.wmem_default = 1048576
net.core.rmem_max = 16777216
net.core.wmem_max = 16777216
net.ipv4.tcp_rmem = 4096 87380 16777216
net.ipv4.tcp_wmem = 4096 65536 16777216
net.ipv4.udp_rmem_min = 16384
net.ipv4.udp_wmem_min = 16384

net.ipv4.tcp_fastopen = 3
net.ipv4.tcp_slow_start_after_idle = 0
net.ipv4.tcp_tw_reuse = 1
net.ipv4.tcp_fin_timeout = 16
net.ipv4.tcp_keepalive_time = 60
net.ipv4.tcp_keepalive_intvl = 10
net.ipv4.tcp_keepalive_probes = 6
net.ipv4.tcp_mtu_probing = 1
net.ipv4.tcp_timestamps = 0
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_rfc1337 = 1
net.ipv4.conf.default.rp_filter = 1
net.ipv4.conf.all.rp_filter = 1
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.all.accept_redirects = 0
net.ipv6.conf.default.accept_redirects = 0
net.ipv6.conf.all.accept_redirects = 0
EOF
### Enable Kernel Parameters
sysctl -p

### Do APT Upgrade & Install
rm /etc/apt/sources.list
touch /etc/apt/sources.list
apt update -y && apt dist-upgrade -y && apt autoremove --purge -y
apt install -y shadowsocks-libev git

### Generate Password & Write To Config File
PASSWORD=$(cat /dev/random | tr -dc 'a-zA-Z0-9' | fold -w 16 | head -n 1)
cat << EOF > /etc/shadowsocks-libev/config.json
{
    "server":["::", "0.0.0.0"],
    "mode":"tcp_and_udp",
    "server_port":443,
    "local_port":1080,
    "nameserver":"8.8.8.8",
    "password":"$PASSWORD",
    "timeout":120,
    "method":"xchacha20-ietf-poly1305",
    "fast_open":true,
    "reuse_port":true,
    "no_delay":true
}
EOF
sed -i "s/LimitNOFILE=32768/LimitNOFILE=51200/g" /lib/systemd/system/shadowsocks-libev.service
sed -i "s/ss-server/ss-server -u/g" /lib/systemd/system/shadowsocks-libev.service

### Enable Service
systemctl daemon-reload
systemctl enable shadowsocks-libev.service
systemctl restart shadowsocks-libev.service

### Echo Password
echo $PASSWORD

### Reboot System
#reboot
