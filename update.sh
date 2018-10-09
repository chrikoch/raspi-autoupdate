#/bin/bash

source config

echo ${PUSHBULLET_TOKEN}

curl -vvv --header 'Access-Token: ${PUSHBULLET_TOKEN}' --header 'Content-Type: application/json' -d '{"type":"note","title":"abc","body":"Inhalt"}' https://api.pushbullet.com/v2/pushes
