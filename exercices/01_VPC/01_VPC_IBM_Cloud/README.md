# Requirements: Install ibm cloud terraform plugin


## Cons about the IBM Cloud Terraform Plugin
- You can't use the ibmcloud cli credentials

## Using the BNPP Formation Account
- You can't create ressource Groups
- You can't create a ssh key

## Using a "free" IBM Cloud Account
- You can't create an other ressource Group
- You can create a ssh key

## Cons using the IBM Cloud as a provider
- even if using data section to select the default resource group, you can't create
a VPC

## Workaround for resource group
https://ibm-cloud.github.io/tf-ibm-docs/v1.2.0/d/resource_group.html

You can select the default resource group and the use it using data variables


## Documentation about IBM Cloud terraform ressources and data
https://ibm-cloud.github.io/tf-ibm-docs/v1.2.0

## ibm_is_vpc
https://ibm-cloud.github.io/tf-ibm-docs/v1.2.0/d/is_vpc.html

### Pro
- Can set the name of the VPC

### cons
- Can't add tags to the IBM ressource (not documented)
- you can't use a `-` in the vpc name

```bash
Error: {"errors":[{"code":"bad_field","message":"Invalid json payload provided","target":{"name":"vpcs.vpcs.name","type":"field"}}],"trace":"b7a252bb-0a4e-4758-9995-afe30193ae7b"}
```

## ibm_is_ssh_key
https://ibm-cloud.github.io/tf-ibm-docs/v1.2.0/d/is_ssh_key.html

This ressource works !

