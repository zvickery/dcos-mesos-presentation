SERVICE=$1

DIG_IP=$(dig +short @m1.dcos $SERVICE.marathon.mesos)
DIG_PORT=$(dig SRV +short @m1.dcos _$SERVICE._tcp.marathon.mesos|cut -d' ' -f3)

echo "dig says: $DIG_IP:$DIG_PORT"
echo
echo "API response:"
curl -s http://m1.dcos:8123/v1/services/_$SERVICE._tcp.marathon.mesos
