# Infrastructure to aws ec2

## 🧰 Introduction
This repo is pre-required for the hello flask repo, when running this source code the hello flak can be run from within the jenkins server that deployed in this infra.


## Procedure: 
1. To run this repo you need to clone/download this IaC.

2. You need to change the tfvars file that is attached for this repo, in accordance to you preferments
   
3. Aeter that the variables are set in accordance to your preferences you will be able to execute the following comments.
```
terraform init
terraform plan
terraform apply
```
The IaC includes the Jenkins Master and Slave containers to run automatically after the terraform apply executed
after Infrastructure is up need to move to the app and make the steps as describe there


## 🔗Hello Flask Repo
[![portfolio](https://img.shields.io/badge/hello-flask-000?style=for-the-badge&logo=ko-fi&logoColor=white)](https://github.com/LizAsraf/hello-flask.git) 