# TP01 - Deploying VPC and 2 instances - A 2-tier routing table on AWS

TLDR:

```bash
terraform init

terraform plan

terraform apply

ssh -J ubuntu@{public-ip-of-nat-gwt-here} ubuntu@{private-ip-of-test-instance-here}

ubuntu@private-instance: ~$ ping {private-ip-of-nat-gwt}

ubuntu@private-instance: ~$ ping 8.8.8.8

ubuntu@private-instance: exit

terraform destroy
```


## Terraform init
`terraform init`

### Output

```bash
λ terraform init

Initializing the backend...

Initializing provider plugins...

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```


## Terraform plan

> We use this command to quickly check if `.tf` files are well written and don't produces errors.
> Also we use this command to see changes to our environment.


```bash
terraform plan
```

### Output

```bash
λ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.


------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.Nat_Jump will be created
  + resource "aws_instance" "Nat_Jump" {
      + ami                          = "ami-035966e8adab4aaad"
      + arn                          = (known after apply)
      + associate_public_ip_address  = true
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = "rufol"
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = false
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name" = "Nat_JumpHost"
        }
      + tenancy                      = (known after apply)
      + user_data                    = "fd7fd02b56ea47dc04205219851480d8840b38cd"
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.Test_Instance will be created
  + resource "aws_instance" "Test_Instance" {
      + ami                          = "ami-035966e8adab4aaad"
      + arn                          = (known after apply)
      + associate_public_ip_address  = false
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = "rufol"
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = false
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name" = "Test_Instance"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_internet_gateway.gw will be created
  + resource "aws_internet_gateway" "gw" {
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "TP_CICD_IGW"
        }
      + vpc_id   = (known after apply)
    }

  # aws_key_pair.rufol will be created
  + resource "aws_key_pair" "rufol" {
      + fingerprint = (known after apply)
      + id          = (known after apply)
      + key_name    = "rufol"
      + key_pair_id = (known after apply)
      + public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjL+9HNSOTpW/PQVeEZMP3D04HBJiPg3BcwYDxpSm++pnOH3FmtBUUq7hPa1eUzf5Hui74SWIs2jfTMaojOMzmj6O9trTyrhYGlnWDSiHK7rCbUtvkdVDNJAJo9V80+8fkq/pmrBNP1RrickHUdTaX11LwZ9XlnlhMqKKT3I1Ubtf5y0v72gST5eBefxNzbR5G+A0a9eEWNCE8nrIRi83r1zJO4qJfa/cjOH0QbQxI1QZvkS8ShcJdrlaqmWgGZyNASgqmJ1PmnmT4K80pPnahCFfQt2wT8MnBj+wIwE5TCe2VKhcE+okwUfl1RxAC3/rRHc1vz+7/WejX9l7bQ3f7p3fKjL59roqcdtxTVW8SCBgZhXT1F+sW9ErPjHjteGFp9P4tsrrGostMnutYjXnsdaZGREs68s77FGIo+a0m43NPnezcj0utFTqbzpvqHed0S4u2K3q6mn5hGhv1f4qjOATpA+FFyesJNuRCGI7PYPiOKeIJWPTqnE9r5E9nRyWe0J67xFsSOewnwfEBiezR90INe8iYszx7GOhVfEKFDMWfFZ6da9LORFUuaibTMo/VPHr5ZfGP0Dqh609pKJvdR7RJgzQI4dZkGt7qgoG08877T2BsvAB85yRifKtemGgcEGSq7+SdD+1A72osHzPG7P8k4y8BsfOYNnZUdRRX1Q=="
    }

  # aws_route_table.Custom_Route_table will be created
  + resource "aws_route_table" "Custom_Route_table" {
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
          + "Name" = "Custom_Route_table"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table.Main_Route_Table will be created
  + resource "aws_route_table" "Main_Route_Table" {
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = ""
              + instance_id               = (known after apply)
              + ipv6_cidr_block           = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
      + tags             = {
          + "Name" = "Main_Route_Table"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.priv will be created
  + resource "aws_route_table_association" "priv" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.pub will be created
  + resource "aws_route_table_association" "pub" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.Nat_Jump will be created
  + resource "aws_security_group" "Nat_Jump" {
      + arn                    = (known after apply)
      + description            = "Allow All inbound traffic from EFREI & Home network"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "192.102.224.0/24",
                  + "46.193.4.20/32",
                  + "172.16.2.0/24",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + name                   = "Nat_Jump"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "allow_all"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.Priv will be created
  + resource "aws_security_group" "Priv" {
      + arn                    = (known after apply)
      + description            = "Allow All inbound/outbound traffic from Public subnet"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "172.16.1.0/24",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + name                   = "Priv"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "allow_all from public subnet"
        }
      + vpc_id                 = (known after apply)
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

Plan: 13 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

![Terraform plan 1](https://imgur.com/3Cz6IeR.png)

![Terraform plan 2](https://imgur.com/psPHrux.png)

## Terraform apply

> We use this command to apply changes to our aws environment.

```bash
terraform apply
```


### Output

```bash
λ terraform apply

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_instance.Nat_Jump will be created
  + resource "aws_instance" "Nat_Jump" {
      + ami                          = "ami-035966e8adab4aaad"
      + arn                          = (known after apply)
      + associate_public_ip_address  = true
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = "rufol"
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = false
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name" = "Nat_JumpHost"
        }
      + tenancy                      = (known after apply)
      + user_data                    = "fd7fd02b56ea47dc04205219851480d8840b38cd"
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_instance.Test_Instance will be created
  + resource "aws_instance" "Test_Instance" {
      + ami                          = "ami-035966e8adab4aaad"
      + arn                          = (known after apply)
      + associate_public_ip_address  = false
      + availability_zone            = (known after apply)
      + cpu_core_count               = (known after apply)
      + cpu_threads_per_core         = (known after apply)
      + get_password_data            = false
      + host_id                      = (known after apply)
      + id                           = (known after apply)
      + instance_state               = (known after apply)
      + instance_type                = "t2.micro"
      + ipv6_address_count           = (known after apply)
      + ipv6_addresses               = (known after apply)
      + key_name                     = "rufol"
      + network_interface_id         = (known after apply)
      + password_data                = (known after apply)
      + placement_group              = (known after apply)
      + primary_network_interface_id = (known after apply)
      + private_dns                  = (known after apply)
      + private_ip                   = (known after apply)
      + public_dns                   = (known after apply)
      + public_ip                    = (known after apply)
      + security_groups              = (known after apply)
      + source_dest_check            = false
      + subnet_id                    = (known after apply)
      + tags                         = {
          + "Name" = "Test_Instance"
        }
      + tenancy                      = (known after apply)
      + volume_tags                  = (known after apply)
      + vpc_security_group_ids       = (known after apply)

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # aws_internet_gateway.gw will be created
  + resource "aws_internet_gateway" "gw" {
      + id       = (known after apply)
      + owner_id = (known after apply)
      + tags     = {
          + "Name" = "TP_CICD_IGW"
        }
      + vpc_id   = (known after apply)
    }

  # aws_key_pair.rufol will be created
  + resource "aws_key_pair" "rufol" {
      + fingerprint = (known after apply)
      + id          = (known after apply)
      + key_name    = "rufol"
      + key_pair_id = (known after apply)
      + public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjL+9HNSOTpW/PQVeEZMP3D04HBJiPg3BcwYDxpSm++pnOH3FmtBUUq7hPa1eUzf5Hui74SWIs2jfTMaojOMzmj6O9trTyrhYGlnWDSiHK7rCbUtvkdVDNJAJo9V80+8fkq/pmrBNP1RrickHUdTaX11LwZ9XlnlhMqKKT3I1Ubtf5y0v72gST5eBefxNzbR5G+A0a9eEWNCE8nrIRi83r1zJO4qJfa/cjOH0QbQxI1QZvkS8ShcJdrlaqmWgGZyNASgqmJ1PmnmT4K80pPnahCFfQt2wT8MnBj+wIwE5TCe2VKhcE+okwUfl1RxAC3/rRHc1vz+7/WejX9l7bQ3f7p3fKjL59roqcdtxTVW8SCBgZhXT1F+sW9ErPjHjteGFp9P4tsrrGostMnutYjXnsdaZGREs68s77FGIo+a0m43NPnezcj0utFTqbzpvqHed0S4u2K3q6mn5hGhv1f4qjOATpA+FFyesJNuRCGI7PYPiOKeIJWPTqnE9r5E9nRyWe0J67xFsSOewnwfEBiezR90INe8iYszx7GOhVfEKFDMWfFZ6da9LORFUuaibTMo/VPHr5ZfGP0Dqh609pKJvdR7RJgzQI4dZkGt7qgoG08877T2BsvAB85yRifKtemGgcEGSq7+SdD+1A72osHzPG7P8k4y8BsfOYNnZUdRRX1Q=="
    }

  # aws_route_table.Custom_Route_table will be created
  + resource "aws_route_table" "Custom_Route_table" {
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
          + "Name" = "Custom_Route_table"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table.Main_Route_Table will be created
  + resource "aws_route_table" "Main_Route_Table" {
      + id               = (known after apply)
      + owner_id         = (known after apply)
      + propagating_vgws = (known after apply)
      + route            = [
          + {
              + cidr_block                = "0.0.0.0/0"
              + egress_only_gateway_id    = ""
              + gateway_id                = ""
              + instance_id               = (known after apply)
              + ipv6_cidr_block           = ""
              + nat_gateway_id            = ""
              + network_interface_id      = ""
              + transit_gateway_id        = ""
              + vpc_peering_connection_id = ""
            },
        ]
      + tags             = {
          + "Name" = "Main_Route_Table"
        }
      + vpc_id           = (known after apply)
    }

  # aws_route_table_association.priv will be created
  + resource "aws_route_table_association" "priv" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_route_table_association.pub will be created
  + resource "aws_route_table_association" "pub" {
      + id             = (known after apply)
      + route_table_id = (known after apply)
      + subnet_id      = (known after apply)
    }

  # aws_security_group.Nat_Jump will be created
  + resource "aws_security_group" "Nat_Jump" {
      + arn                    = (known after apply)
      + description            = "Allow All inbound traffic from EFREI & Home network"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "192.102.224.0/24",
                  + "46.193.4.20/32",
                  + "172.16.2.0/24",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + name                   = "Nat_Jump"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "allow_all"
        }
      + vpc_id                 = (known after apply)
    }

  # aws_security_group.Priv will be created
  + resource "aws_security_group" "Priv" {
      + arn                    = (known after apply)
      + description            = "Allow All inbound/outbound traffic from Public subnet"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "172.16.1.0/24",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + name                   = "Priv"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags                   = {
          + "Name" = "allow_all from public subnet"
        }
      + vpc_id                 = (known after apply)
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

Plan: 13 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_key_pair.rufol: Creating...
aws_vpc.vpc_tp: Creating...
aws_key_pair.rufol: Creation complete after 0s [id=rufol]
aws_vpc.vpc_tp: Creation complete after 3s [id=vpc-031733d3530f4aab2]
aws_internet_gateway.gw: Creating...
aws_subnet.sub_priv: Creating...
aws_subnet.sub_pub: Creating...
aws_subnet.sub_priv: Creation complete after 2s [id=subnet-07393e2409f448057]
aws_subnet.sub_pub: Creation complete after 2s [id=subnet-0518c4789905a536a]
aws_internet_gateway.gw: Creation complete after 2s [id=igw-04b5cb761af46518c]
aws_security_group.Priv: Creating...
aws_security_group.Nat_Jump: Creating...
aws_route_table.Custom_Route_table: Creating...
aws_route_table.Custom_Route_table: Creation complete after 1s [id=rtb-0551645dfa0a16faf]
aws_route_table_association.pub: Creating...
aws_route_table_association.pub: Creation complete after 0s [id=rtbassoc-036af5911ed2c272b]
aws_security_group.Nat_Jump: Creation complete after 2s [id=sg-0c29bfabfee466ff9]
aws_security_group.Priv: Creation complete after 2s [id=sg-0679d656e3c73a92d]
aws_instance.Nat_Jump: Creating...
aws_instance.Test_Instance: Creating...
aws_instance.Test_Instance: Still creating... [10s elapsed]
aws_instance.Nat_Jump: Still creating... [10s elapsed]
aws_instance.Test_Instance: Still creating... [20s elapsed]
aws_instance.Nat_Jump: Still creating... [20s elapsed]
aws_instance.Test_Instance: Still creating... [30s elapsed]
aws_instance.Nat_Jump: Still creating... [30s elapsed]
aws_instance.Test_Instance: Creation complete after 34s [id=i-035944b39f6213740]
aws_instance.Nat_Jump: Creation complete after 35s [id=i-0fa0674004ce15d09]
aws_route_table.Main_Route_Table: Creating...
aws_route_table.Main_Route_Table: Creation complete after 1s [id=rtb-00e085db5608d73cb]
aws_route_table_association.priv: Creating...
aws_route_table_association.priv: Creation complete after 0s [id=rtbassoc-0f345e1d5d109efe0]

Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

ngwt-instance = ec2-34-241-211-236.eu-west-1.compute.amazonaws.com
test-instance = ip-172-16-2-183.eu-west-1.compute.internal
```

![Terraform apply 1](https://imgur.com/zMJxXgz.png)

![Terraform apply 2](https://imgur.com/QEsIkBV.png)


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

### Output

```bash
λ ssh -J ubuntu@ec2-34-241-211-236.eu-west-1.compute.amazonaws.com ubuntu@ip-172-16-2-183.eu-west-1.compute.internal
The authenticity of host 'ec2-34-241-211-236.eu-west-1.compute.amazonaws.com (34.241.211.236)' can't be established.
ECDSA key fingerprint is SHA256:nTg+ZPBt7Wx3k1IqCMtEa0DZYLWHtAtjpo+30mmf1o8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ec2-34-241-211-236.eu-west-1.compute.amazonaws.com,34.241.211.236' (ECDSA) to the list of known hosts.
Enter passphrase for key '/c/Users/rufol/.ssh/id_rsa':
The authenticity of host 'ip-172-16-2-183.eu-west-1.compute.internal (<no hostip for proxy command>)' can't be established.
ECDSA key fingerprint is SHA256:cwauVFCkDlpzHSob6yuZX5TXSUz/tQgYHH2FTrb42IY.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ip-172-16-2-183.eu-west-1.compute.internal' (ECDSA) to the list of known hosts.
Enter passphrase for key '/c/Users/rufol/.ssh/id_rsa':
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-1057-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Feb 13 07:29:46 UTC 2020

  System load:  0.15              Processes:           89
  Usage of /:   13.6% of 7.69GB   Users logged in:     0
  Memory usage: 14%               IP address for eth0: 172.16.2.183
  Swap usage:   0%

0 packages can be updated.
0 updates are security updates.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-172-16-2-183:~$
```


![Jump SSH to Test instance from NAT public instance](https://imgur.com/etYI4tl.png)



## Ping public address from test instance (in the private subnet)

> We finally have to ping test our setup, to do so we will as requested in the exercice material ping the `8.8.8.8` IP address

```bash
ping 8.8.8.8
```

### Output

```bash
ubuntu@ip-172-16-2-183:~$ ping 8.8.8.8 -c 5                                                                                                                                                                        PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=49 time=2.72 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=49 time=1.39 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=49 time=1.40 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=49 time=1.34 ms
64 bytes from 8.8.8.8: icmp_seq=5 ttl=49 time=1.36 ms

--- 8.8.8.8 ping statistics ---
5 packets transmitted, 5 received, 0% packet loss, time 4006ms
rtt min/avg/max/mdev = 1.341/1.644/2.724/0.542 ms
ubuntu@ip-172-16-2-183:~$
```

![Ping to 8.8.8.8 from Test instance](https://imgur.com/4nIL1h2.png)


## Terraform destroy

> It's now the time to clean up the setup. we will use the `terraform destroy` command to remove all created ressources


```bash
terraform destroy
```


### Output

```bash
λ terraform destroy
aws_key_pair.rufol: Refreshing state... [id=rufol]
aws_vpc.vpc_tp: Refreshing state... [id=vpc-031733d3530f4aab2]
aws_internet_gateway.gw: Refreshing state... [id=igw-04b5cb761af46518c]
aws_subnet.sub_pub: Refreshing state... [id=subnet-0518c4789905a536a]
aws_subnet.sub_priv: Refreshing state... [id=subnet-07393e2409f448057]
aws_security_group.Priv: Refreshing state... [id=sg-0679d656e3c73a92d]
aws_route_table.Custom_Route_table: Refreshing state... [id=rtb-0551645dfa0a16faf]
aws_security_group.Nat_Jump: Refreshing state... [id=sg-0c29bfabfee466ff9]
aws_instance.Test_Instance: Refreshing state... [id=i-035944b39f6213740]
aws_route_table_association.pub: Refreshing state... [id=rtbassoc-036af5911ed2c272b]
aws_instance.Nat_Jump: Refreshing state... [id=i-0fa0674004ce15d09]
aws_route_table.Main_Route_Table: Refreshing state... [id=rtb-00e085db5608d73cb]
aws_route_table_association.priv: Refreshing state... [id=rtbassoc-0f345e1d5d109efe0]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # aws_instance.Nat_Jump will be destroyed
  - resource "aws_instance" "Nat_Jump" {
      - ami                          = "ami-035966e8adab4aaad" -> null
      - arn                          = "arn:aws:ec2:eu-west-1:893379205229:instance/i-0fa0674004ce15d09" -> null
      - associate_public_ip_address  = true -> null
      - availability_zone            = "eu-west-1a" -> null
      - cpu_core_count               = 1 -> null
      - cpu_threads_per_core         = 1 -> null
      - disable_api_termination      = false -> null
      - ebs_optimized                = false -> null
      - get_password_data            = false -> null
      - id                           = "i-0fa0674004ce15d09" -> null
      - instance_state               = "running" -> null
      - instance_type                = "t2.micro" -> null
      - ipv6_address_count           = 0 -> null
      - ipv6_addresses               = [] -> null
      - key_name                     = "rufol" -> null
      - monitoring                   = false -> null
      - primary_network_interface_id = "eni-01ac9edf04e7b9d36" -> null
      - private_dns                  = "ip-172-16-1-167.eu-west-1.compute.internal" -> null
      - private_ip                   = "172.16.1.167" -> null
      - public_dns                   = "ec2-34-241-211-236.eu-west-1.compute.amazonaws.com" -> null
      - public_ip                    = "34.241.211.236" -> null
      - security_groups              = [] -> null
      - source_dest_check            = false -> null
      - subnet_id                    = "subnet-0518c4789905a536a" -> null
      - tags                         = {
          - "Name" = "Nat_JumpHost"
        } -> null
      - tenancy                      = "default" -> null
      - user_data                    = "fd7fd02b56ea47dc04205219851480d8840b38cd" -> null
      - volume_tags                  = {} -> null
      - vpc_security_group_ids       = [
          - "sg-0c29bfabfee466ff9",
        ] -> null

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - volume_id             = "vol-0633ac680655c9704" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp2" -> null
        }
    }

  # aws_instance.Test_Instance will be destroyed
  - resource "aws_instance" "Test_Instance" {
      - ami                          = "ami-035966e8adab4aaad" -> null
      - arn                          = "arn:aws:ec2:eu-west-1:893379205229:instance/i-035944b39f6213740" -> null
      - associate_public_ip_address  = false -> null
      - availability_zone            = "eu-west-1a" -> null
      - cpu_core_count               = 1 -> null
      - cpu_threads_per_core         = 1 -> null
      - disable_api_termination      = false -> null
      - ebs_optimized                = false -> null
      - get_password_data            = false -> null
      - id                           = "i-035944b39f6213740" -> null
      - instance_state               = "running" -> null
      - instance_type                = "t2.micro" -> null
      - ipv6_address_count           = 0 -> null
      - ipv6_addresses               = [] -> null
      - key_name                     = "rufol" -> null
      - monitoring                   = false -> null
      - primary_network_interface_id = "eni-0818cfe80ddee03a8" -> null
      - private_dns                  = "ip-172-16-2-183.eu-west-1.compute.internal" -> null
      - private_ip                   = "172.16.2.183" -> null
      - security_groups              = [] -> null
      - source_dest_check            = false -> null
      - subnet_id                    = "subnet-07393e2409f448057" -> null
      - tags                         = {
          - "Name" = "Test_Instance"
        } -> null
      - tenancy                      = "default" -> null
      - volume_tags                  = {} -> null
      - vpc_security_group_ids       = [
          - "sg-0679d656e3c73a92d",
        ] -> null

      - credit_specification {
          - cpu_credits = "standard" -> null
        }

      - root_block_device {
          - delete_on_termination = true -> null
          - encrypted             = false -> null
          - iops                  = 100 -> null
          - volume_id             = "vol-0fa19c4b5ae300160" -> null
          - volume_size           = 8 -> null
          - volume_type           = "gp2" -> null
        }
    }

  # aws_internet_gateway.gw will be destroyed
  - resource "aws_internet_gateway" "gw" {
      - id       = "igw-04b5cb761af46518c" -> null
      - owner_id = "893379205229" -> null
      - tags     = {
          - "Name" = "TP_CICD_IGW"
        } -> null
      - vpc_id   = "vpc-031733d3530f4aab2" -> null
    }

  # aws_key_pair.rufol will be destroyed
  - resource "aws_key_pair" "rufol" {
      - fingerprint = "c3:4b:a9:15:c2:03:6a:99:55:c8:29:d2:6c:de:64:91" -> null
      - id          = "rufol" -> null
      - key_name    = "rufol" -> null
      - key_pair_id = "key-0437cf19884fd1f15" -> null
      - public_key  = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjL+9HNSOTpW/PQVeEZMP3D04HBJiPg3BcwYDxpSm++pnOH3FmtBUUq7hPa1eUzf5Hui74SWIs2jfTMaojOMzmj6O9trTyrhYGlnWDSiHK7rCbUtvkdVDNJAJo9V80+8fkq/pmrBNP1RrickHUdTaX11LwZ9XlnlhMqKKT3I1Ubtf5y0v72gST5eBefxNzbR5G+A0a9eEWNCE8nrIRi83r1zJO4qJfa/cjOH0QbQxI1QZvkS8ShcJdrlaqmWgGZyNASgqmJ1PmnmT4K80pPnahCFfQt2wT8MnBj+wIwE5TCe2VKhcE+okwUfl1RxAC3/rRHc1vz+7/WejX9l7bQ3f7p3fKjL59roqcdtxTVW8SCBgZhXT1F+sW9ErPjHjteGFp9P4tsrrGostMnutYjXnsdaZGREs68s77FGIo+a0m43NPnezcj0utFTqbzpvqHed0S4u2K3q6mn5hGhv1f4qjOATpA+FFyesJNuRCGI7PYPiOKeIJWPTqnE9r5E9nRyWe0J67xFsSOewnwfEBiezR90INe8iYszx7GOhVfEKFDMWfFZ6da9LORFUuaibTMo/VPHr5ZfGP0Dqh609pKJvdR7RJgzQI4dZkGt7qgoG08877T2BsvAB85yRifKtemGgcEGSq7+SdD+1A72osHzPG7P8k4y8BsfOYNnZUdRRX1Q==" -> null
      - tags        = {} -> null
    }

  # aws_route_table.Custom_Route_table will be destroyed
  - resource "aws_route_table" "Custom_Route_table" {
      - id               = "rtb-0551645dfa0a16faf" -> null
      - owner_id         = "893379205229" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - cidr_block                = "0.0.0.0/0"
              - egress_only_gateway_id    = ""
              - gateway_id                = "igw-04b5cb761af46518c"
              - instance_id               = ""
              - ipv6_cidr_block           = ""
              - nat_gateway_id            = ""
              - network_interface_id      = ""
              - transit_gateway_id        = ""
              - vpc_peering_connection_id = ""
            },
        ] -> null
      - tags             = {
          - "Name" = "Custom_Route_table"
        } -> null
      - vpc_id           = "vpc-031733d3530f4aab2" -> null
    }

  # aws_route_table.Main_Route_Table will be destroyed
  - resource "aws_route_table" "Main_Route_Table" {
      - id               = "rtb-00e085db5608d73cb" -> null
      - owner_id         = "893379205229" -> null
      - propagating_vgws = [] -> null
      - route            = [
          - {
              - cidr_block                = "0.0.0.0/0"
              - egress_only_gateway_id    = ""
              - gateway_id                = ""
              - instance_id               = "i-0fa0674004ce15d09"
              - ipv6_cidr_block           = ""
              - nat_gateway_id            = ""
              - network_interface_id      = "eni-01ac9edf04e7b9d36"
              - transit_gateway_id        = ""
              - vpc_peering_connection_id = ""
            },
        ] -> null
      - tags             = {
          - "Name" = "Main_Route_Table"
        } -> null
      - vpc_id           = "vpc-031733d3530f4aab2" -> null
    }

  # aws_route_table_association.priv will be destroyed
  - resource "aws_route_table_association" "priv" {
      - id             = "rtbassoc-0f345e1d5d109efe0" -> null
      - route_table_id = "rtb-00e085db5608d73cb" -> null
      - subnet_id      = "subnet-07393e2409f448057" -> null
    }

  # aws_route_table_association.pub will be destroyed
  - resource "aws_route_table_association" "pub" {
      - id             = "rtbassoc-036af5911ed2c272b" -> null
      - route_table_id = "rtb-0551645dfa0a16faf" -> null
      - subnet_id      = "subnet-0518c4789905a536a" -> null
    }

  # aws_security_group.Nat_Jump will be destroyed
  - resource "aws_security_group" "Nat_Jump" {
      - arn                    = "arn:aws:ec2:eu-west-1:893379205229:security-group/sg-0c29bfabfee466ff9" -> null
      - description            = "Allow All inbound traffic from EFREI & Home network" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - id                     = "sg-0c29bfabfee466ff9" -> null
      - ingress                = [
          - {
              - cidr_blocks      = [
                  - "192.102.224.0/24",
                  - "46.193.4.20/32",
                  - "172.16.2.0/24",
                ]
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - name                   = "Nat_Jump" -> null
      - owner_id               = "893379205229" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {
          - "Name" = "allow_all"
        } -> null
      - vpc_id                 = "vpc-031733d3530f4aab2" -> null
    }

  # aws_security_group.Priv will be destroyed
  - resource "aws_security_group" "Priv" {
      - arn                    = "arn:aws:ec2:eu-west-1:893379205229:security-group/sg-0679d656e3c73a92d" -> null
      - description            = "Allow All inbound/outbound traffic from Public subnet" -> null
      - egress                 = [
          - {
              - cidr_blocks      = [
                  - "0.0.0.0/0",
                ]
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - id                     = "sg-0679d656e3c73a92d" -> null
      - ingress                = [
          - {
              - cidr_blocks      = [
                  - "172.16.1.0/24",
                ]
              - description      = ""
              - from_port        = 0
              - ipv6_cidr_blocks = []
              - prefix_list_ids  = []
              - protocol         = "-1"
              - security_groups  = []
              - self             = false
              - to_port          = 0
            },
        ] -> null
      - name                   = "Priv" -> null
      - owner_id               = "893379205229" -> null
      - revoke_rules_on_delete = false -> null
      - tags                   = {
          - "Name" = "allow_all from public subnet"
        } -> null
      - vpc_id                 = "vpc-031733d3530f4aab2" -> null
    }

  # aws_subnet.sub_priv will be destroyed
  - resource "aws_subnet" "sub_priv" {
      - arn                             = "arn:aws:ec2:eu-west-1:893379205229:subnet/subnet-07393e2409f448057" -> null
      - assign_ipv6_address_on_creation = false -> null
      - availability_zone               = "eu-west-1a" -> null
      - availability_zone_id            = "euw1-az3" -> null
      - cidr_block                      = "172.16.2.0/24" -> null
      - id                              = "subnet-07393e2409f448057" -> null
      - map_public_ip_on_launch         = false -> null
      - owner_id                        = "893379205229" -> null
      - tags                            = {
          - "Name" = "TP_CICD_Private"
        } -> null
      - vpc_id                          = "vpc-031733d3530f4aab2" -> null
    }

  # aws_subnet.sub_pub will be destroyed
  - resource "aws_subnet" "sub_pub" {
      - arn                             = "arn:aws:ec2:eu-west-1:893379205229:subnet/subnet-0518c4789905a536a" -> null
      - assign_ipv6_address_on_creation = false -> null
      - availability_zone               = "eu-west-1a" -> null
      - availability_zone_id            = "euw1-az3" -> null
      - cidr_block                      = "172.16.1.0/24" -> null
      - id                              = "subnet-0518c4789905a536a" -> null
      - map_public_ip_on_launch         = false -> null
      - owner_id                        = "893379205229" -> null
      - tags                            = {
          - "Name" = "TP_CICD_Public"
        } -> null
      - vpc_id                          = "vpc-031733d3530f4aab2" -> null
    }

  # aws_vpc.vpc_tp will be destroyed
  - resource "aws_vpc" "vpc_tp" {
      - arn                              = "arn:aws:ec2:eu-west-1:893379205229:vpc/vpc-031733d3530f4aab2" -> null
      - assign_generated_ipv6_cidr_block = false -> null
      - cidr_block                       = "172.16.0.0/16" -> null
      - default_network_acl_id           = "acl-0abad215ce1290a39" -> null
      - default_route_table_id           = "rtb-0f172c7b7b3422598" -> null
      - default_security_group_id        = "sg-0525f6555891ed684" -> null
      - dhcp_options_id                  = "dopt-7b98cc1d" -> null
      - enable_classiclink               = false -> null
      - enable_classiclink_dns_support   = false -> null
      - enable_dns_hostnames             = true -> null
      - enable_dns_support               = true -> null
      - id                               = "vpc-031733d3530f4aab2" -> null
      - instance_tenancy                 = "default" -> null
      - main_route_table_id              = "rtb-0f172c7b7b3422598" -> null
      - owner_id                         = "893379205229" -> null
      - tags                             = {
          - "Name" = "TP_CICD"
        } -> null
    }

Plan: 0 to add, 0 to change, 13 to destroy.

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

aws_route_table_association.pub: Destroying... [id=rtbassoc-036af5911ed2c272b]
aws_route_table_association.priv: Destroying... [id=rtbassoc-0f345e1d5d109efe0]
aws_instance.Test_Instance: Destroying... [id=i-035944b39f6213740]
aws_route_table_association.pub: Destruction complete after 1s
aws_route_table.Custom_Route_table: Destroying... [id=rtb-0551645dfa0a16faf]
aws_route_table_association.priv: Destruction complete after 1s
aws_route_table.Main_Route_Table: Destroying... [id=rtb-00e085db5608d73cb]
aws_route_table.Custom_Route_table: Destruction complete after 0s
aws_internet_gateway.gw: Destroying... [id=igw-04b5cb761af46518c]
aws_route_table.Main_Route_Table: Destruction complete after 0s
aws_instance.Nat_Jump: Destroying... [id=i-0fa0674004ce15d09]
aws_instance.Test_Instance: Still destroying... [id=i-035944b39f6213740, 10s elapsed]
aws_internet_gateway.gw: Still destroying... [id=igw-04b5cb761af46518c, 10s elapsed]
aws_instance.Nat_Jump: Still destroying... [id=i-0fa0674004ce15d09, 10s elapsed]
aws_internet_gateway.gw: Destruction complete after 19s
aws_instance.Test_Instance: Still destroying... [id=i-035944b39f6213740, 20s elapsed]
aws_instance.Nat_Jump: Still destroying... [id=i-0fa0674004ce15d09, 20s elapsed]
aws_instance.Test_Instance: Still destroying... [id=i-035944b39f6213740, 30s elapsed]
aws_instance.Test_Instance: Destruction complete after 31s
aws_security_group.Priv: Destroying... [id=sg-0679d656e3c73a92d]
aws_instance.Nat_Jump: Still destroying... [id=i-0fa0674004ce15d09, 30s elapsed]
aws_instance.Nat_Jump: Destruction complete after 30s
aws_key_pair.rufol: Destroying... [id=rufol]
aws_security_group.Nat_Jump: Destroying... [id=sg-0c29bfabfee466ff9]
aws_key_pair.rufol: Destruction complete after 1s
aws_security_group.Priv: Destruction complete after 1s
aws_subnet.sub_pub: Destroying... [id=subnet-0518c4789905a536a]
aws_subnet.sub_pub: Destruction complete after 0s
aws_security_group.Nat_Jump: Destruction complete after 2s
aws_subnet.sub_priv: Destroying... [id=subnet-07393e2409f448057]
aws_subnet.sub_priv: Destruction complete after 0s
aws_vpc.vpc_tp: Destroying... [id=vpc-031733d3530f4aab2]
aws_vpc.vpc_tp: Destruction complete after 1s

Destroy complete! Resources: 13 destroyed.
```

![Terraform destroy 1](https://imgur.com/LcyrMEj.png)

![Terraform destroy 1](https://imgur.com/1UzfrLC.png)
