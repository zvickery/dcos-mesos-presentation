#!/bin/bash

curl="curl --retry 5 -k -m3 -i -L"
curl_put="$curl --fail -X PUT"
metronome="http://m1.dcos:9000/v1/jobs"

function create_or_update_schedule(){
  exists=$($curl -s -o /dev/null -w "%{http_code}" $metronome/$1/schedules/$2)
  if [ $exists -eq 200 ]; then
    echo "Exists... updating"
    $curl_put -H 'Content-Type: application/json' $metronome/$1/schedules/$2 -d "$(cat $3)"
  else
    # Create
    echo "Does not exist... creating"
    $curl -H 'Content-Type: application/json' $metronome/$1/schedules -d "$(cat $3)"
  fi
}

function create_or_update_job(){
  exists=$($curl -s -o /dev/null -w "%{http_code}" $metronome/$1)
  if [ $exists -eq 200 ]; then
    echo "Exists... updating"
    $curl_put --fail -H 'Content-Type: application/json' $metronome/$1 -d "$(cat $2)"
  else
    # Create
    echo "Does not exist... creating"
    $curl --fail -H 'Content-Type: application/json' $metronome -d "$(cat $2)"
  fi
}

create_or_update_job "hello" "metronome-job1.json"
create_or_update_schedule "hello" "every5" "metronome-schedule.json"
create_or_update_job "hello-ad-hoc" "metronome-job2.json"
