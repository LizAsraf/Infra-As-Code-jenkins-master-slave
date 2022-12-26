#!/bin/sh
master=$1
workDir=/home/jenkins/agent
docker start builder
echo curl -sO http://${master}:8080/jnlpJars/agent.jar > slave.sh
echo java -jar agent.jar -jnlpUrl http://${master}:8080/manage/computer/builder/jenkins-agent.jnlp -secret e1b175440b3c0148cac24af2bb0c617b2c23f68fc4ceb9310d79384b09b4ce8d -workDir ${workDir} >> slave.sh
chmod +x slave.sh
docker cp slave.sh builder:/home/jenkins/slave.sh
docker exec -id builder bash slave.sh