```bash

C:\WORK\cours-devOps\terraform
λ terraform apply
aws_vpc.vpc_tp: Refreshing state... [id=vpc-0e06bb50390ccd3be]
aws_internet_gateway.gw: Refreshing state... [id=igw-0fb8bb2841e0e2780]
aws_route_table.r: Refreshing state... [id=rtb-051236580e691cbef]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_internet_gateway.gw will be created
  + resource "aws_internet_gateway" "gw" {
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "TP_CICD_IGW"
        }
      + vpc_id   = (known after apply)
    }

  # aws_route_table.r will be created
  + resource "aws_route_table" "r" {
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = (known after apply)
              + instance_id               = ""
              + ipv6_cidr_block           = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
      + tags             = {
          + "Name" = "TP_CICD_Default"
        }
      + vpc_id           = (known after apply)
    }

  # aws_subnet.sub_priv will be created
  + resource "aws_subnet" "sub_priv" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "eu-west-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "172.16.2.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "TP_CICD_Private"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_subnet.sub_pub will be created
  + resource "aws_subnet" "sub_pub" {
      + arn                             = (known after apply)
      + assign_ipv6_address_on_creation = false
      + availability_zone               = "eu-west-1a"
      + availability_zone_id            = (known after apply)
      + cidr_block                      = "172.16.1.0/24"
      + id                              = (known after apply)
      + ipv6_cidr_block                 = (known after apply)
      + ipv6_cidr_block_association_id  = (known after apply)
      + map_public_ip_on_launch         = false
      + owner_id                        = (known after apply)
      + tags                            = {
          + "Name" = "TP_CICD_Public"
        }
      + vpc_id                          = (known after apply)
    }

  # aws_vpc.vpc_tp will be created
  + resource "aws_vpc" "vpc_tp" {
      + arn                              = (known after apply)
      + assign_generated_ipv6_cidr_block = false
      + cidr_block                       = "172.16.0.0/16"
      + default_network_acl_id           = (known after apply)
      + default_route_table_id           = (known after apply)
      + default_security_group_id        = (known after apply)
      + dhcp_options_id                  = (known after apply)
      + enable_classiclink               = (known after apply)
      + enable_classiclink_dns_support   = (known after apply)
      + enable_dns_hostnames             = true
      + enable_dns_support               = true
      + id                               = (known after apply)
      + instance_tenancy                 = "default"
      + ipv6_association_id              = (known after apply)
      + ipv6_cidr_block                  = (known after apply)
      + main_route_table_id              = (known after apply)
      + owner_id                         = (known after apply)
      + tags                             = {
          + "Name" = "TP_CICD"
        }
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.vpc_tp: Creating...
aws_vpc.vpc_tp: Creation complete after 2s [id=vpc-08ac0c4357ab346c1]
aws_internet_gateway.gw: Creating...
aws_subnet.sub_priv: Creating...
aws_subnet.sub_pub: Creating...
aws_subnet.sub_pub: Creation complete after 2s [id=subnet-041a3cb37bb8635ab]
aws_internet_gateway.gw: Creation complete after 2s [id=igw-0fd736904958ab40a]
aws_route_table.r: Creating...
aws_subnet.sub_priv: Creation complete after 2s [id=subnet-0cc9c3658b6bc4e6a]
aws_route_table.r: Creation complete after 1s [id=rtb-0f29c76421f04d412]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

```
