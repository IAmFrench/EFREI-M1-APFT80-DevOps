# TP03 - Terraform

## Objective
> For this exercice, we need to deploy an application with terraform.

> To do so, we will first deploy the "baseline" infrastructure (vpc, subnets, NAT, IGWT, etc.) resources needed to deploy our application instances.

## Deploying the infrastructure
> First we have to clean our VPCs, subnets, and instances

> Then we will create our AMI using ansible and packer

> And finally we will deploy our application based on the custom AMI previously builded

## Building the AMI

To create the AMI we will follow the TP2 `README.md` file.

Then we need to connect to our work instance :

![connect to work instance](https://imgur.com/daH64LI.png)

![connect 2 instance 2](https://imgur.com/bLzVesV.png)

> Note: in the last exercice we will be using MS Powershell

![connect powershell shell](https://imgur.com/WTopTHC.png)

The we will install Ansible and Packer tools

![Install ansible and packer](https://imgur.com/e5EOHvV.png)

![Install ansible and packer 2](https://imgur.com/bgX4QW9.png)

![Install ansible and packer 3](https://imgur.com/NehNJlo.png)

> Using config files from TP2 we can create the AMI 

![config ansible](https://imgur.com/bvTVhnD.png)


We can see there folders and files provided by our teachers

- `BuildAMI.json`
- `Deploy_Infra`
- `Deploy_Website`

Then we create a folder `Build_WebAMI` and place inside it these files :
- `BuildAMI.json`
- `Play.yml` (our playbook)

![list build webami directory](https://imgur.com/xO4yVfu.png)

Now we will create the application infrastructure needed by our application to run (scale, and HA)

![buildAMI.json](https://imgur.com/aq5KVlf.png)

This file `buildAMI.json` helps us to describe how we wants to deploy the infrastructure

![play.yml](https://imgur.com/CWP4oWr.png)

It's now time to deploy our application

## Deploy our Infra as Code using Terraform

![terraform directoy](https://imgur.com/JT6l8la.png)


![terraform main content](https://imgur.com/kpLbHGU.png)

![id AMI](https://imgur.com/NPOpE3Z.png)


![sg](https://imgur.com/9zJJTXf.png)

