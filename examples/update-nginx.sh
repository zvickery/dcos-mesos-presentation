name=nginx

curl="curl --fail --retry 10 -v -m3 -s -i -L -X PUT"
endpoint="http://m1.dcos:8080/v2/apps/$name?force=true"

$curl -H 'Content-Type: application/json' $endpoint -d "$(cat nginx-marathon.json)"
