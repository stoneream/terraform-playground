#!/bin/bash

PROFILE=$1
TARGET_INSTANCE=$2

if [ -z "$PROFILE" ] || [ -z "$TARGET_INSTANCE" ]; then
  echo "Usage: $0 <profile> <target-instance>"
  exit 1
fi

nohup aws --profile $PROFILE ssm start-session \
--target $TARGET \
--document-name AWS-StartPortForwardingSession \
--parameters '{"portNumber":["7860"],"localPortNumber":["7860"]}' &

nohup aws --profile $PROFILE ssm start-session \
--target $TARGET \
--document-name AWS-StartPortForwardingSession \
--parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}' &
