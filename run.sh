#!/bin/bash
set -eo pipefail

echo "[confd] booting container. ETCD: $ETCD"
# until confd -onetime -node http://bursuc.sparta.email:4001 -config-file /etc/confd/conf.d/hosts.toml; do
# Try to make initial configuration every 5 seconds until successful
until confd -onetime -node $ETCD -config-file /etc/confd/conf.d/hosts.toml; do
    echo "[hosts] waiting for confd to create initial hosts configuration"
    sleep 5
done

confd -interval 10 -node $ETCD -config-file /etc/confd/conf.d/hosts.toml &
echo "[confd] is now monitoring etcd for changes..."

# Follow the logs to allow the script to continue running
tail -f /var/log/lastlog
