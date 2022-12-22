# infrastructure to aws ec2

## 🧰 Prerequisites
Two aws EC2 instances as cloud infrastructure service.
each Operating system deployed as ubuntu system. 
One instance Named ‘master’ and the second ‘slave’


## Procedure: 
1. On ‘master’ - installed containerized Jenkins server
	you will be able to enter to the system as a builder user with username ‘builder’ and password ‘Otom8oEx’

2. On ‘slave’- there is a user inside the system called builder that the master can SSH connet to this user with no password requirements.
	The jenkins slave also contanerized.
   
3. There is a job calld hello-flask on the Jenkins UI that can be run mannually throth the UI
- This job runing only with the builder agent (slave OS)
- After the job completed seccessfully the finished artifact called hello-${BUILD_NUMBER}.tar.gz stored in the master container 
file path : ** $JENKINS_HOME/jobs/$your_job_name/branches/$branch_name/builds/$build_number/archive/$file_name.tar.gz **
 also you will be able to find the finger print and the last successful built artifact on the 
  **UI under the branch master above the jobs **
  
## Contributing
To run theis server required to run this code with master-ip argument and slave-ip argument
```
#!/bin/sh
master=$1
slave=$2
workDir="/home/jenkins/agent"
ssh -i "/home/liz/Downloads/lizasraf.pem" ec2-user@${master} \
"docker start jenkins"
echo "jenkins server is up and runing"
ssh -i "/home/liz/Downloads/lizasraf.pem" ec2-user@${slave} \
"docker start builder;\
echo curl -sO http://${master}:8080/jnlpJars/agent.jar > slave.sh ;\
echo java -jar agent.jar -jnlpUrl http://${master}:8080/manage/computer/builder/jenkins-agent.jnlp -secret e1b175440b3c0148cac24af2bb0c617b2c23f68fc4ceb9310d79384b09b4ce8d -workDir ${workDir} >> slave.sh;\
chmod +x slave.sh;\
docker cp slave.sh builder:/home/jenkins/slave.sh;\
docker exec -id builder bash slave.sh;"
echo "jenkins slave is up and runing"
```
required to make it exutable
```
chmod +x run jenkins.sh
```
```
./jenkins.sh xx.xx.xx.xx yy.yy.yy.yy
```
  
## 🔗 Infra-As-Code for a ezier deployment
[![portfolio](https://img.shields.io/badge/infrastructure-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://www.udemy.com/user/ar-shankar/) 