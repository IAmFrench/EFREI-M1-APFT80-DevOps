# Ex1 - Deploying VPC and 2 instances - A 2-tier routing table

TLDR:

```bash
terraform plan

terraform apply

ssh -J ubuntu@{public-ip-of-nat-gwt-here} ubuntu@{private-ip-of-test-instance-here}

ubuntu@private-instance: ~$ ping {private-ip-of-nat-gwt}

ubuntu@private-instance: ~$ ping 8.8.8.8

ubuntu@private-instance: exit

terraform destroy
```


## Terraform plan

> We use this command to quickly check if the *tf files are well writen and don't produces errors.
> Also we use this command to see changes to our environment.

![Terraform plan 1](https://drive.google.com/a/pares-corp.com/uc?id=1sENyaHWrZSetpP_3ktNN1UcDqiDOX5N_)

![Terraform plan 2](https://drive.google.com/a/pares-corp.com/uc?id=1z-mFrPaSVdrYkwPNPFMDoQfvZeVCtqY5)


```bash
terraform plan
```


## Terraform apply

> We use this command to apply changes to our aws environment.

```bash
terraform apply
```

![Terraform apply 1](https://drive.google.com/a/pares-corp.com/uc?id=1PMn8UAY2n6ccO1LZXGX1qhxD2dm321vN)

![Terraform apply 2](https://drive.google.com/a/pares-corp.com/uc?id=1oVh-XIHP_0rYahcOFgNxso0ujljjgWEV)


## SSH Jump to the test instance

> Thanks to the 2 terraform outputs we don't have to login into the aws console to optain the public DNS address of the NAT instance and the private DNS address of the Test instance.


```bash
Outputs:

ngwt-instance = ec2-63-32-94-162.eu-west-1.compute.amazonaws.com
test-instance = ip-172-16-2-63.eu-west-1.compute.internal
```

```bash
ssh -J ubuntu@{public-dns-name-of-NAT-instance} ubuntu@{private-dns-name-of-test-instance}

```

![Jump SSH to Test instance from NAT public instance](https://drive.google.com/a/pares-corp.com/uc?id=1RVyk0k05Hcg2Yo4nAs9x1GtJmAOwfhtE)



## Ping public address from test instance (in the private subnet)

> We finally have to ping test our setup, to do so we will as requested in the exercice material ping the `8.8.8.8` IP address

```bash
ping 8.8.8.8
```

![Ping to 8.8.8.8 from Test instance](https://drive.google.com/a/pares-corp.com/uc?id=1-rIcgLna12qUHwnEYlNWLN7AcL4g-htn)


## Terraform destroy

> It's now the time to clean up the setup. we will use the `terraform destroy` command to remove all created ressources


```bash
terraform destroy
```

![Terraform destroy 1](https://drive.google.com/a/pares-corp.com/uc?id=1Ia4HTYk2C93i3VmE0oJio3HJJdMP0K_9)

![Terraform destroy 1](https://drive.google.com/a/pares-corp.com/uc?id=1PEfj3f7VKoR-hZg5Jcs_rWMkwZoRNrlD)