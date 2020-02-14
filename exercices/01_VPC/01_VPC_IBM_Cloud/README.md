# Requirements: Install ibm cloud terraform plugin
> [Install Terraform provider]()


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

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.ibm: version = "~> 1.2"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

```


## Terraform plan

> We use this command to quickly check if the *tf files are well written and don't produces errors.
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

data.ibm_resource_group.Training: Refreshing state...

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # ibm_is_floating_ip.nat_gwt_instance_floating_ip will be created
  + resource "ibm_is_floating_ip" "nat_gwt_instance_floating_ip" {
      + address                 = (known after apply)
      + id                      = (known after apply)
      + name                    = "pf-itops-nat-gwt-flt-ip"
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + resource_status         = (known after apply)
      + status                  = (known after apply)
      + target                  = (known after apply)
      + zone                    = (known after apply)
    }

  # ibm_is_instance.nat_gwt_instance will be created
  + resource "ibm_is_instance" "nat_gwt_instance" {
      + gpu                     = (known after apply)
      + id                      = (known after apply)
      + image                   = "r006-d2f5be47-f7fb-4e6e-b4ab-87734fd8d12b"
      + keys                    = (known after apply)
      + memory                  = (known after apply)
      + name                    = "pf-itops-nat-gwt"
      + profile                 = "cp2-2x4"
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + resource_status         = (known after apply)
      + status                  = (known after apply)
      + tags                    = (known after apply)
      + user_data               = <<~EOT
            #!/bin/bash
            sysctl -w net.ipv4.ip_forward=1
            /sbin/iptables -t nat -A POSTROUTING -o enp0s1 -j MASQUERADE
        EOT
      + vcpu                    = (known after apply)
      + volume_attachments      = (known after apply)
      + vpc                     = (known after apply)
      + zone                    = "us-south-1"

      + boot_volume {
          + encryption = (known after apply)
          + iops       = (known after apply)
          + name       = (known after apply)
          + profile    = (known after apply)
          + size       = (known after apply)
        }

      + primary_network_interface {
          + id                   = (known after apply)
          + name                 = "eth0"
          + primary_ipv4_address = (known after apply)
          + security_groups      = (known after apply)
          + subnet               = (known after apply)
        }
    }

  # ibm_is_instance.private_instance will be created
  + resource "ibm_is_instance" "private_instance" {
      + gpu                     = (known after apply)
      + id                      = (known after apply)
      + image                   = "r006-d2f5be47-f7fb-4e6e-b4ab-87734fd8d12b"
      + keys                    = (known after apply)
      + memory                  = (known after apply)
      + name                    = "pf-itops-private"
      + profile                 = "cp2-2x4"
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + resource_status         = (known after apply)
      + status                  = (known after apply)
      + tags                    = (known after apply)
      + vcpu                    = (known after apply)
      + volume_attachments      = (known after apply)
      + vpc                     = (known after apply)
      + zone                    = "us-south-1"

      + boot_volume {
          + encryption = (known after apply)
          + iops       = (known after apply)
          + name       = (known after apply)
          + profile    = (known after apply)
          + size       = (known after apply)
        }

      + primary_network_interface {
          + id                   = (known after apply)
          + name                 = "eth0"
          + primary_ipv4_address = (known after apply)
          + security_groups      = (known after apply)
          + subnet               = (known after apply)
        }
    }

  # ibm_is_security_group.private will be created
  + resource "ibm_is_security_group" "private" {
      + id                      = (known after apply)
      + name                    = "pf-itops-private-sg"
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + rules                   = (known after apply)
      + vpc                     = (known after apply)
    }

  # ibm_is_security_group.public will be created
  + resource "ibm_is_security_group" "public" {
      + id                      = (known after apply)
      + name                    = "pf-itops-public-sg"
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + rules                   = (known after apply)
      + vpc                     = (known after apply)
    }

  # ibm_is_security_group_rule.private_sg_rule_all_in_from_public_subnet will be created
  + resource "ibm_is_security_group_rule" "private_sg_rule_all_in_from_public_subnet" {
      + direction  = "inbound"
      + group      = (known after apply)
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = (known after apply)
      + rule_id    = (known after apply)
    }

  # ibm_is_security_group_rule.private_sg_rule_all_out will be created
  + resource "ibm_is_security_group_rule" "private_sg_rule_all_out" {
      + direction  = "outbound"
      + group      = (known after apply)
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "0.0.0.0/0"
      + rule_id    = (known after apply)
    }

  # ibm_is_security_group_rule.public_sg_rule_all_in_from_home will be created
  + resource "ibm_is_security_group_rule" "public_sg_rule_all_in_from_home" {
      + direction  = "inbound"
      + group      = (known after apply)
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "46.193.4.20/32"
      + rule_id    = (known after apply)
    }

  # ibm_is_security_group_rule.public_sg_rule_all_in_from_unicity will be created
  + resource "ibm_is_security_group_rule" "public_sg_rule_all_in_from_unicity" {
      + direction  = "inbound"
      + group      = (known after apply)
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "217.163.58.252/32"
      + rule_id    = (known after apply)
    }

  # ibm_is_security_group_rule.public_sg_rule_all_out will be created
  + resource "ibm_is_security_group_rule" "public_sg_rule_all_out" {
      + direction  = "outbound"
      + group      = (known after apply)
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "0.0.0.0/0"
      + rule_id    = (known after apply)
    }

  # ibm_is_ssh_key.ssh_Key will be created
  + resource "ibm_is_ssh_key" "ssh_Key" {
      + fingerprint             = (known after apply)
      + id                      = (known after apply)
      + length                  = (known after apply)
      + name                    = "pf-itops-apares"
      + public_key              = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjL+9HNSOTpW/PQVeEZMP3D04HBJiPg3BcwYDxpSm++pnOH3FmtBUUq7hPa1eUzf5Hui74SWIs2jfTMaojOMzmj6O9trTyrhYGlnWDSiHK7rCbUtvkdVDNJAJo9V80+8fkq/pmrBNP1RrickHUdTaX11LwZ9XlnlhMqKKT3I1Ubtf5y0v72gST5eBefxNzbR5G+A0a9eEWNCE8nrIRi83r1zJO4qJfa/cjOH0QbQxI1QZvkS8ShcJdrlaqmWgGZyNASgqmJ1PmnmT4K80pPnahCFfQt2wT8MnBj+wIwE5TCe2VKhcE+okwUfl1RxAC3/rRHc1vz+7/WejX9l7bQ3f7p3fKjL59roqcdtxTVW8SCBgZhXT1F+sW9ErPjHjteGFp9P4tsrrGostMnutYjXnsdaZGREs68s77FGIo+a0m43NPnezcj0utFTqbzpvqHed0S4u2K3q6mn5hGhv1f4qjOATpA+FFyesJNuRCGI7PYPiOKeIJWPTqnE9r5E9nRyWe0J67xFsSOewnwfEBiezR90INe8iYszx7GOhVfEKFDMWfFZ6da9LORFUuaibTMo/VPHr5ZfGP0Dqh609pKJvdR7RJgzQI4dZkGt7qgoG08877T2BsvAB85yRifKtemGgcEGSq7+SdD+1A72osHzPG7P8k4y8BsfOYNnZUdRRX1Q=="
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + type                    = (known after apply)
    }

  # ibm_is_subnet.private will be created
  + resource "ibm_is_subnet" "private" {
      + available_ipv4_address_count = (known after apply)
      + id                           = (known after apply)
      + ip_version                   = "ipv4"
      + ipv4_cidr_block              = (known after apply)
      + ipv6_cidr_block              = (known after apply)
      + name                         = "pf-itops-private"
      + network_acl                  = (known after apply)
      + resource_controller_url      = (known after apply)
      + resource_crn                 = (known after apply)
      + resource_group               = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name          = (known after apply)
      + resource_name                = (known after apply)
      + resource_status              = (known after apply)
      + status                       = (known after apply)
      + total_ipv4_address_count     = 8
      + vpc                          = (known after apply)
      + zone                         = "us-south-1"
    }

  # ibm_is_subnet.public will be created
  + resource "ibm_is_subnet" "public" {
      + available_ipv4_address_count = (known after apply)
      + id                           = (known after apply)
      + ip_version                   = "ipv4"
      + ipv4_cidr_block              = (known after apply)
      + ipv6_cidr_block              = (known after apply)
      + name                         = "pf-itops-public"
      + network_acl                  = (known after apply)
      + resource_controller_url      = (known after apply)
      + resource_crn                 = (known after apply)
      + resource_group               = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name          = (known after apply)
      + resource_name                = (known after apply)
      + resource_status              = (known after apply)
      + status                       = (known after apply)
      + total_ipv4_address_count     = 8
      + vpc                          = (known after apply)
      + zone                         = "us-south-1"
    }

  # ibm_is_vpc.PF_ITOPS_vpc will be created
  + resource "ibm_is_vpc" "PF_ITOPS_vpc" {
      + address_prefix_management = "auto"
      + classic_access            = false
      + default_network_acl       = (known after apply)
      + default_security_group    = (known after apply)
      + id                        = (known after apply)
      + name                      = "pf-itops-vpc"
      + resource_controller_url   = (known after apply)
      + resource_crn              = (known after apply)
      + resource_group            = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name       = (known after apply)
      + resource_name             = (known after apply)
      + resource_status           = (known after apply)
      + status                    = (known after apply)
      + tags                      = [
          + "entity:pf-it-ops",
          + "env:dev",
        ]
    }

  # ibm_is_vpc_route.private_sub will be created
  + resource "ibm_is_vpc_route" "private_sub" {
      + destination = "0.0.0.0/0"
      + id          = (known after apply)
      + name        = "pf-itops-route-private"
      + next_hop    = (known after apply)
      + status      = (known after apply)
      + vpc         = (known after apply)
      + zone        = "us-south-1"
    }

Plan: 15 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

![Terraform plan 1](https://imgur.com/iqSg7od.png)

![Terraform plan 2](https://imgur.com/mYM6Vpm.png)

## Terraform apply

> We use this command to apply changes to our aws environment.

```bash
terraform apply
```


### Output

```bash

λ terraform apply
data.ibm_resource_group.Training: Refreshing state...

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # ibm_is_floating_ip.nat_gwt_instance_floating_ip will be created
  + resource "ibm_is_floating_ip" "nat_gwt_instance_floating_ip" {
      + address                 = (known after apply)
      + id                      = (known after apply)
      + name                    = "pf-itops-nat-gwt-flt-ip"
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + resource_status         = (known after apply)
      + status                  = (known after apply)
      + target                  = (known after apply)
      + zone                    = (known after apply)
    }

  # ibm_is_instance.nat_gwt_instance will be created
  + resource "ibm_is_instance" "nat_gwt_instance" {
      + gpu                     = (known after apply)
      + id                      = (known after apply)
      + image                   = "r006-d2f5be47-f7fb-4e6e-b4ab-87734fd8d12b"
      + keys                    = (known after apply)
      + memory                  = (known after apply)
      + name                    = "pf-itops-nat-gwt"
      + profile                 = "cp2-2x4"
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + resource_status         = (known after apply)
      + status                  = (known after apply)
      + tags                    = (known after apply)
      + user_data               = <<~EOT
            #!/bin/bash
            sysctl -w net.ipv4.ip_forward=1
            /sbin/iptables -t nat -A POSTROUTING -o enp0s1 -j MASQUERADE
        EOT
      + vcpu                    = (known after apply)
      + volume_attachments      = (known after apply)
      + vpc                     = (known after apply)
      + zone                    = "us-south-1"

      + boot_volume {
          + encryption = (known after apply)
          + iops       = (known after apply)
          + name       = (known after apply)
          + profile    = (known after apply)
          + size       = (known after apply)
        }

      + primary_network_interface {
          + id                   = (known after apply)
          + name                 = "eth0"
          + primary_ipv4_address = (known after apply)
          + security_groups      = (known after apply)
          + subnet               = (known after apply)
        }
    }

  # ibm_is_instance.private_instance will be created
  + resource "ibm_is_instance" "private_instance" {
      + gpu                     = (known after apply)
      + id                      = (known after apply)
      + image                   = "r006-d2f5be47-f7fb-4e6e-b4ab-87734fd8d12b"
      + keys                    = (known after apply)
      + memory                  = (known after apply)
      + name                    = "pf-itops-private"
      + profile                 = "cp2-2x4"
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + resource_status         = (known after apply)
      + status                  = (known after apply)
      + tags                    = (known after apply)
      + vcpu                    = (known after apply)
      + volume_attachments      = (known after apply)
      + vpc                     = (known after apply)
      + zone                    = "us-south-1"

      + boot_volume {
          + encryption = (known after apply)
          + iops       = (known after apply)
          + name       = (known after apply)
          + profile    = (known after apply)
          + size       = (known after apply)
        }

      + primary_network_interface {
          + id                   = (known after apply)
          + name                 = "eth0"
          + primary_ipv4_address = (known after apply)
          + security_groups      = (known after apply)
          + subnet               = (known after apply)
        }
    }

  # ibm_is_security_group.private will be created
  + resource "ibm_is_security_group" "private" {
      + id                      = (known after apply)
      + name                    = "pf-itops-private-sg"
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + rules                   = (known after apply)
      + vpc                     = (known after apply)
    }

  # ibm_is_security_group.public will be created
  + resource "ibm_is_security_group" "public" {
      + id                      = (known after apply)
      + name                    = "pf-itops-public-sg"
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + rules                   = (known after apply)
      + vpc                     = (known after apply)
    }

  # ibm_is_security_group_rule.private_sg_rule_all_in_from_public_subnet will be created
  + resource "ibm_is_security_group_rule" "private_sg_rule_all_in_from_public_subnet" {
      + direction  = "inbound"
      + group      = (known after apply)
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = (known after apply)
      + rule_id    = (known after apply)
    }

  # ibm_is_security_group_rule.private_sg_rule_all_out will be created
  + resource "ibm_is_security_group_rule" "private_sg_rule_all_out" {
      + direction  = "outbound"
      + group      = (known after apply)
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "0.0.0.0/0"
      + rule_id    = (known after apply)
    }

  # ibm_is_security_group_rule.public_sg_rule_all_in_from_home will be created
  + resource "ibm_is_security_group_rule" "public_sg_rule_all_in_from_home" {
      + direction  = "inbound"
      + group      = (known after apply)
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "46.193.4.20/32"
      + rule_id    = (known after apply)
    }

  # ibm_is_security_group_rule.public_sg_rule_all_in_from_unicity will be created
  + resource "ibm_is_security_group_rule" "public_sg_rule_all_in_from_unicity" {
      + direction  = "inbound"
      + group      = (known after apply)
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "217.163.58.252/32"
      + rule_id    = (known after apply)
    }

  # ibm_is_security_group_rule.public_sg_rule_all_out will be created
  + resource "ibm_is_security_group_rule" "public_sg_rule_all_out" {
      + direction  = "outbound"
      + group      = (known after apply)
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "0.0.0.0/0"
      + rule_id    = (known after apply)
    }

  # ibm_is_ssh_key.ssh_Key will be created
  + resource "ibm_is_ssh_key" "ssh_Key" {
      + fingerprint             = (known after apply)
      + id                      = (known after apply)
      + length                  = (known after apply)
      + name                    = "pf-itops-apares"
      + public_key              = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjL+9HNSOTpW/PQVeEZMP3D04HBJiPg3BcwYDxpSm++pnOH3FmtBUUq7hPa1eUzf5Hui74SWIs2jfTMaojOMzmj6O9trTyrhYGlnWDSiHK7rCbUtvkdVDNJAJo9V80+8fkq/pmrBNP1RrickHUdTaX11LwZ9XlnlhMqKKT3I1Ubtf5y0v72gST5eBefxNzbR5G+A0a9eEWNCE8nrIRi83r1zJO4qJfa/cjOH0QbQxI1QZvkS8ShcJdrlaqmWgGZyNASgqmJ1PmnmT4K80pPnahCFfQt2wT8MnBj+wIwE5TCe2VKhcE+okwUfl1RxAC3/rRHc1vz+7/WejX9l7bQ3f7p3fKjL59roqcdtxTVW8SCBgZhXT1F+sW9ErPjHjteGFp9P4tsrrGostMnutYjXnsdaZGREs68s77FGIo+a0m43NPnezcj0utFTqbzpvqHed0S4u2K3q6mn5hGhv1f4qjOATpA+FFyesJNuRCGI7PYPiOKeIJWPTqnE9r5E9nRyWe0J67xFsSOewnwfEBiezR90INe8iYszx7GOhVfEKFDMWfFZ6da9LORFUuaibTMo/VPHr5ZfGP0Dqh609pKJvdR7RJgzQI4dZkGt7qgoG08877T2BsvAB85yRifKtemGgcEGSq7+SdD+1A72osHzPG7P8k4y8BsfOYNnZUdRRX1Q=="
      + resource_controller_url = (known after apply)
      + resource_crn            = (known after apply)
      + resource_group          = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name     = (known after apply)
      + resource_name           = (known after apply)
      + type                    = (known after apply)
    }

  # ibm_is_subnet.private will be created
  + resource "ibm_is_subnet" "private" {
      + available_ipv4_address_count = (known after apply)
      + id                           = (known after apply)
      + ip_version                   = "ipv4"
      + ipv4_cidr_block              = (known after apply)
      + ipv6_cidr_block              = (known after apply)
      + name                         = "pf-itops-private"
      + network_acl                  = (known after apply)
      + resource_controller_url      = (known after apply)
      + resource_crn                 = (known after apply)
      + resource_group               = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name          = (known after apply)
      + resource_name                = (known after apply)
      + resource_status              = (known after apply)
      + status                       = (known after apply)
      + total_ipv4_address_count     = 8
      + vpc                          = (known after apply)
      + zone                         = "us-south-1"
    }

  # ibm_is_subnet.public will be created
  + resource "ibm_is_subnet" "public" {
      + available_ipv4_address_count = (known after apply)
      + id                           = (known after apply)
      + ip_version                   = "ipv4"
      + ipv4_cidr_block              = (known after apply)
      + ipv6_cidr_block              = (known after apply)
      + name                         = "pf-itops-public"
      + network_acl                  = (known after apply)
      + resource_controller_url      = (known after apply)
      + resource_crn                 = (known after apply)
      + resource_group               = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name          = (known after apply)
      + resource_name                = (known after apply)
      + resource_status              = (known after apply)
      + status                       = (known after apply)
      + total_ipv4_address_count     = 8
      + vpc                          = (known after apply)
      + zone                         = "us-south-1"
    }

  # ibm_is_vpc.PF_ITOPS_vpc will be created
  + resource "ibm_is_vpc" "PF_ITOPS_vpc" {
      + address_prefix_management = "auto"
      + classic_access            = false
      + default_network_acl       = (known after apply)
      + default_security_group    = (known after apply)
      + id                        = (known after apply)
      + name                      = "pf-itops-vpc"
      + resource_controller_url   = (known after apply)
      + resource_crn              = (known after apply)
      + resource_group            = "fef8a58a10a945819e5d0a4027ebdb39"
      + resource_group_name       = (known after apply)
      + resource_name             = (known after apply)
      + resource_status           = (known after apply)
      + status                    = (known after apply)
      + tags                      = [
          + "entity:pf-it-ops",
          + "env:dev",
        ]
    }

  # ibm_is_vpc_route.private_sub will be created
  + resource "ibm_is_vpc_route" "private_sub" {
      + destination = "0.0.0.0/0"
      + id          = (known after apply)
      + name        = "pf-itops-route-private"
      + next_hop    = (known after apply)
      + status      = (known after apply)
      + vpc         = (known after apply)
      + zone        = "us-south-1"
    }

Plan: 15 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

ibm_is_ssh_key.ssh_Key: Creating...
ibm_is_vpc.PF_ITOPS_vpc: Creating...
ibm_is_ssh_key.ssh_Key: Creation complete after 2s [id=r006-c3418715-ac2d-4335-a172-8002a9cefc93]
ibm_is_vpc.PF_ITOPS_vpc: Still creating... [10s elapsed]
ibm_is_vpc.PF_ITOPS_vpc: Creation complete after 16s [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b]
ibm_is_security_group.private: Creating...
ibm_is_security_group.public: Creating...
ibm_is_subnet.public: Creating...
ibm_is_subnet.private: Creating...
ibm_is_security_group.private: Creation complete after 1s [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce]
ibm_is_security_group_rule.private_sg_rule_all_out: Creating...
ibm_is_security_group.public: Creation complete after 2s [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2]
ibm_is_security_group_rule.public_sg_rule_all_out: Creating...
ibm_is_security_group_rule.public_sg_rule_all_in_from_unicity: Creating...
ibm_is_security_group_rule.public_sg_rule_all_in_from_home: Creating...
ibm_is_security_group_rule.private_sg_rule_all_out: Creation complete after 1s [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce.r006-f612bc01-e0ce-4d7e-91e4-7eb8c8701c04]
ibm_is_security_group_rule.public_sg_rule_all_in_from_home: Creation complete after 1s [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-2640a8a2-c85c-4beb-be62-938657bd43ac]
ibm_is_security_group_rule.public_sg_rule_all_in_from_unicity: Creation complete after 2s [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-08e6e54b-9c5e-4f93-839b-2df04b6a67f4]
ibm_is_security_group_rule.public_sg_rule_all_out: Creation complete after 2s [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-6e07925e-5bc5-4dae-b38a-21be1cbb910c]
ibm_is_subnet.private: Still creating... [10s elapsed]
ibm_is_subnet.public: Still creating... [10s elapsed]
ibm_is_subnet.public: Creation complete after 12s [id=0717-0f0193d3-a55a-4e04-91a4-bcf526ade497]
ibm_is_security_group_rule.private_sg_rule_all_in_from_public_subnet: Creating...
ibm_is_instance.nat_gwt_instance: Creating...
ibm_is_security_group_rule.private_sg_rule_all_in_from_public_subnet: Creation complete after 1s [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce.r006-2b2d1901-b719-411d-abf9-f58fe30d334c]
ibm_is_subnet.private: Still creating... [20s elapsed]
ibm_is_instance.nat_gwt_instance: Still creating... [10s elapsed]
ibm_is_subnet.private: Creation complete after 23s [id=0717-9e32e51b-49f9-4fa2-a868-41129fb0a459]
ibm_is_instance.private_instance: Creating...
ibm_is_instance.nat_gwt_instance: Still creating... [20s elapsed]
ibm_is_instance.private_instance: Still creating... [10s elapsed]
ibm_is_instance.nat_gwt_instance: Still creating... [30s elapsed]
ibm_is_instance.private_instance: Still creating... [20s elapsed]
ibm_is_instance.nat_gwt_instance: Creation complete after 35s [id=0717_aae1e1ab-5be5-44c4-b62d-e0780a4bae2e]
ibm_is_vpc_route.private_sub: Creating...
ibm_is_floating_ip.nat_gwt_instance_floating_ip: Creating...
ibm_is_instance.private_instance: Still creating... [30s elapsed]
ibm_is_vpc_route.private_sub: Still creating... [10s elapsed]
ibm_is_floating_ip.nat_gwt_instance_floating_ip: Still creating... [10s elapsed]
ibm_is_instance.private_instance: Creation complete after 35s [id=0717_09dd6617-6b6e-4998-800e-7e1589618d2b]
ibm_is_floating_ip.nat_gwt_instance_floating_ip: Creation complete after 10s [id=r006-91d4b15b-13e1-4b05-92e5-43e5587a77a9]
ibm_is_vpc_route.private_sub: Creation complete after 10s [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b/r006-2ab224e1-f22e-4741-8f0a-549586b6c209]

Apply complete! Resources: 15 added, 0 changed, 0 destroyed.

Outputs:

ngwt-instance = 52.116.128.53
private-instance = 10.240.0.12
private_sub-ipv4_cidr_block = 10.240.0.8/29
public_sub-ipv4_cidr_block = 10.240.0.0/29

```

![Terraform apply 1](https://imgur.com/8eXCUIa.png)

![Terraform apply 2](https://imgur.com/Rz1F71m.png)


## SSH Jump to the test instance

> Thanks to the 2 terraform outputs we don't have to login into the aws console to optain the public IP address of the NAT instance and the private IP address of the Test instance.


```bash
Outputs:

ngwt-instance = 52.116.128.53
private-instance = 10.240.0.12
private_sub-ipv4_cidr_block = 10.240.0.8/29
public_sub-ipv4_cidr_block = 10.240.0.0/29
```

```bash
ssh -J ubuntu@{public-dns-name-of-NAT-instance} ubuntu@{private-dns-name-of-test-instance}

```

### Output

```bash

λ ssh -J ubuntu@52.116.128.53 ubuntu@10.240.0.12
ssh: connect to host 52.116.128.53 port 22: Connection timed out
ssh_exchange_identification: Connection closed by remote host

```


### Adding the School IP source range

```hlc
# Allow only traffic from school
resource "ibm_is_security_group_rule" "public_sg_rule_all_in_from_school" {
  group     = ibm_is_security_group.public.id
  direction = "inbound"
  remote = "192.102.224.0/24"
}
```

`terraform plan`

```bash

λ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.ibm_resource_group.Training: Refreshing state...
ibm_is_ssh_key.ssh_Key: Refreshing state... [id=r006-c3418715-ac2d-4335-a172-8002a9cefc93]
ibm_is_vpc.PF_ITOPS_vpc: Refreshing state... [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b]
ibm_is_security_group.public: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2]
ibm_is_subnet.public: Refreshing state... [id=0717-0f0193d3-a55a-4e04-91a4-bcf526ade497]
ibm_is_security_group.private: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce]
ibm_is_subnet.private: Refreshing state... [id=0717-9e32e51b-49f9-4fa2-a868-41129fb0a459]
ibm_is_security_group_rule.private_sg_rule_all_out: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce.r006-f612bc01-e0ce-4d7e-91e4-7eb8c8701c04]
ibm_is_security_group_rule.public_sg_rule_all_in_from_unicity: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-08e6e54b-9c5e-4f93-839b-2df04b6a67f4]
ibm_is_security_group_rule.public_sg_rule_all_out: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-6e07925e-5bc5-4dae-b38a-21be1cbb910c]
ibm_is_security_group_rule.public_sg_rule_all_in_from_home: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-2640a8a2-c85c-4beb-be62-938657bd43ac]
ibm_is_instance.private_instance: Refreshing state... [id=0717_09dd6617-6b6e-4998-800e-7e1589618d2b]
ibm_is_security_group_rule.private_sg_rule_all_in_from_public_subnet: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce.r006-2b2d1901-b719-411d-abf9-f58fe30d334c]
ibm_is_instance.nat_gwt_instance: Refreshing state... [id=0717_aae1e1ab-5be5-44c4-b62d-e0780a4bae2e]
ibm_is_vpc_route.private_sub: Refreshing state... [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b/r006-2ab224e1-f22e-4741-8f0a-549586b6c209]
ibm_is_floating_ip.nat_gwt_instance_floating_ip: Refreshing state... [id=r006-91d4b15b-13e1-4b05-92e5-43e5587a77a9]

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
  ~ update in-place

Terraform will perform the following actions:

  # ibm_is_security_group_rule.public_sg_rule_all_in_from_school will be created
  + resource "ibm_is_security_group_rule" "public_sg_rule_all_in_from_school" {
      + direction  = "inbound"
      + group      = "r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2"
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "192.102.224.0/24"
      + rule_id    = (known after apply)
    }

  # ibm_is_vpc.PF_ITOPS_vpc will be updated in-place
  ~ resource "ibm_is_vpc" "PF_ITOPS_vpc" {
        address_prefix_management = "auto"
        classic_access            = false
        default_network_acl       = "r006-c73f7515-20f1-42a1-a938-91451cea60d8"
        default_security_group    = "r006-bb98706c-2f56-48cc-8142-9606e050e7fb"
        id                        = "r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b"
        name                      = "pf-itops-vpc"
        resource_controller_url   = "https://cloud.ibm.com/vpc-ext/network/vpcs"
        resource_crn              = "crn:v1:bluemix:public:is:us-south:a/a3c1da9c4e4a4cdaaa92d1edeb7f4868::vpc:r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b"
        resource_group            = "fef8a58a10a945819e5d0a4027ebdb39"
        resource_group_name       = "Training"
        resource_name             = "pf-itops-vpc"
        resource_status           = "available"
        status                    = "available"
      ~ tags                      = [
          + "entity:pf-it-ops",
          + "env:dev",
        ]
    }

Plan: 1 to add, 1 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

`terraform apply`


```bash

λ terraform apply
data.ibm_resource_group.Training: Refreshing state...
ibm_is_ssh_key.ssh_Key: Refreshing state... [id=r006-c3418715-ac2d-4335-a172-8002a9cefc93]
ibm_is_vpc.PF_ITOPS_vpc: Refreshing state... [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b]
ibm_is_subnet.public: Refreshing state... [id=0717-0f0193d3-a55a-4e04-91a4-bcf526ade497]
ibm_is_security_group.public: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2]
ibm_is_security_group.private: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce]
ibm_is_subnet.private: Refreshing state... [id=0717-9e32e51b-49f9-4fa2-a868-41129fb0a459]
ibm_is_security_group_rule.public_sg_rule_all_out: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-6e07925e-5bc5-4dae-b38a-21be1cbb910c]
ibm_is_security_group_rule.private_sg_rule_all_out: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce.r006-f612bc01-e0ce-4d7e-91e4-7eb8c8701c04]
ibm_is_security_group_rule.public_sg_rule_all_in_from_home: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-2640a8a2-c85c-4beb-be62-938657bd43ac]
ibm_is_security_group_rule.public_sg_rule_all_in_from_unicity: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-08e6e54b-9c5e-4f93-839b-2df04b6a67f4]
ibm_is_instance.private_instance: Refreshing state... [id=0717_09dd6617-6b6e-4998-800e-7e1589618d2b]
ibm_is_security_group_rule.private_sg_rule_all_in_from_public_subnet: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce.r006-2b2d1901-b719-411d-abf9-f58fe30d334c]
ibm_is_instance.nat_gwt_instance: Refreshing state... [id=0717_aae1e1ab-5be5-44c4-b62d-e0780a4bae2e]
ibm_is_floating_ip.nat_gwt_instance_floating_ip: Refreshing state... [id=r006-91d4b15b-13e1-4b05-92e5-43e5587a77a9]
ibm_is_vpc_route.private_sub: Refreshing state... [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b/r006-2ab224e1-f22e-4741-8f0a-549586b6c209]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
  ~ update in-place

Terraform will perform the following actions:

  # ibm_is_security_group_rule.public_sg_rule_all_in_from_school will be created
  + resource "ibm_is_security_group_rule" "public_sg_rule_all_in_from_school" {
      + direction  = "inbound"
      + group      = "r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2"
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "192.102.224.0/24"
      + rule_id    = (known after apply)
    }

  # ibm_is_vpc.PF_ITOPS_vpc will be updated in-place
  ~ resource "ibm_is_vpc" "PF_ITOPS_vpc" {
        address_prefix_management = "auto"
        classic_access            = false
        default_network_acl       = "r006-c73f7515-20f1-42a1-a938-91451cea60d8"
        default_security_group    = "r006-bb98706c-2f56-48cc-8142-9606e050e7fb"
        id                        = "r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b"
        name                      = "pf-itops-vpc"
        resource_controller_url   = "https://cloud.ibm.com/vpc-ext/network/vpcs"
        resource_crn              = "crn:v1:bluemix:public:is:us-south:a/a3c1da9c4e4a4cdaaa92d1edeb7f4868::vpc:r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b"
        resource_group            = "fef8a58a10a945819e5d0a4027ebdb39"
        resource_group_name       = "Training"
        resource_name             = "pf-itops-vpc"
        resource_status           = "available"
        status                    = "available"
      ~ tags                      = [
          + "entity:pf-it-ops",
          + "env:dev",
        ]
    }

Plan: 1 to add, 1 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

ibm_is_security_group_rule.public_sg_rule_all_in_from_school: Creating...
ibm_is_vpc.PF_ITOPS_vpc: Modifying... [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b]
ibm_is_security_group_rule.public_sg_rule_all_in_from_school: Creation complete after 1s [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-777e6ff8-c3fb-4392-ba2c-fb46f8a7b2cc]
ibm_is_vpc.PF_ITOPS_vpc: Modifications complete after 2s [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b]

Apply complete! Resources: 1 added, 1 changed, 0 destroyed.

Outputs:

ngwt-instance = 52.116.128.53
private-instance = 10.240.0.12
private_sub-ipv4_cidr_block = 10.240.0.8/29
public_sub-ipv4_cidr_block = 10.240.0.0/29

```

### Test again

```bash

λ ssh -J ubuntu@52.116.128.53 ubuntu@10.240.0.12
The authenticity of host '52.116.128.53 (52.116.128.53)' can't be established.
ECDSA key fingerprint is SHA256:JcauUmk/OoQtQ61sSmmtjU8zy0pRrNHVmBNh+GpvGMM.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '52.116.128.53' (ECDSA) to the list of known hosts.
Enter passphrase for key '/c/Users/rufol/.ssh/id_rsa':
The authenticity of host '10.240.0.12 (<no hostip for proxy command>)' can't be established.
ECDSA key fingerprint is SHA256:m3prafvibf06Vg5bnZIeZpz1tv4L1e288GIOb8MpMSU.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '10.240.0.12' (ECDSA) to the list of known hosts.
Enter passphrase for key '/c/Users/rufol/.ssh/id_rsa':
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-66-generic ppc64le)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Feb 13 01:58:44 CST 2020

  System load:  0.0               Processes:             112
  Usage of /:   2.2% of 97.92GB   Users logged in:       0
  Memory usage: 9%                IP address for enp0s1: 10.240.0.12
  Swap usage:   0%


102 packages can be updated.
0 updates are security updates.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@pf-itops-private:~$

```


## Ping 8.8.8.8

```bash

```

> The private instance can't ping
> The private instance can't ping the nat-gwt instance
> So we edit the ibm_is_security_group_rule of the public subnet


```hlc

# Allow traffic from private subnet
resource "ibm_is_security_group_rule" "public_sg_rule_all_in_from_private_subnet" {
  group     = ibm_is_security_group.public.id
  direction = "inbound"
  remote = ibm_is_subnet.private.ipv4_cidr_block
}

```


```bash

λ terraform plan
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

data.ibm_resource_group.Training: Refreshing state...
ibm_is_ssh_key.ssh_Key: Refreshing state... [id=r006-c3418715-ac2d-4335-a172-8002a9cefc93]
ibm_is_vpc.PF_ITOPS_vpc: Refreshing state... [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b]
ibm_is_security_group.private: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce]
ibm_is_subnet.public: Refreshing state... [id=0717-0f0193d3-a55a-4e04-91a4-bcf526ade497]
ibm_is_subnet.private: Refreshing state... [id=0717-9e32e51b-49f9-4fa2-a868-41129fb0a459]
ibm_is_security_group.public: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2]
ibm_is_security_group_rule.public_sg_rule_all_in_from_school: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-777e6ff8-c3fb-4392-ba2c-fb46f8a7b2cc]
ibm_is_security_group_rule.public_sg_rule_all_in_from_unicity: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-08e6e54b-9c5e-4f93-839b-2df04b6a67f4]
ibm_is_security_group_rule.public_sg_rule_all_in_from_home: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-2640a8a2-c85c-4beb-be62-938657bd43ac]
ibm_is_security_group_rule.public_sg_rule_all_out: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-6e07925e-5bc5-4dae-b38a-21be1cbb910c]
ibm_is_security_group_rule.private_sg_rule_all_out: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce.r006-f612bc01-e0ce-4d7e-91e4-7eb8c8701c04]
ibm_is_security_group_rule.private_sg_rule_all_in_from_public_subnet: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce.r006-2b2d1901-b719-411d-abf9-f58fe30d334c]
ibm_is_instance.nat_gwt_instance: Refreshing state... [id=0717_aae1e1ab-5be5-44c4-b62d-e0780a4bae2e]
ibm_is_instance.private_instance: Refreshing state... [id=0717_09dd6617-6b6e-4998-800e-7e1589618d2b]
ibm_is_vpc_route.private_sub: Refreshing state... [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b/r006-2ab224e1-f22e-4741-8f0a-549586b6c209]
ibm_is_floating_ip.nat_gwt_instance_floating_ip: Refreshing state... [id=r006-91d4b15b-13e1-4b05-92e5-43e5587a77a9]

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
  ~ update in-place

Terraform will perform the following actions:

  # ibm_is_security_group_rule.public_sg_rule_all_in_from_private_subnet will be created
  + resource "ibm_is_security_group_rule" "public_sg_rule_all_in_from_private_subnet" {
      + direction  = "inbound"
      + group      = "r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2"
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "10.240.0.8/29"
      + rule_id    = (known after apply)
    }

  # ibm_is_vpc.PF_ITOPS_vpc will be updated in-place
  ~ resource "ibm_is_vpc" "PF_ITOPS_vpc" {
        address_prefix_management = "auto"
        classic_access            = false
        default_network_acl       = "r006-c73f7515-20f1-42a1-a938-91451cea60d8"
        default_security_group    = "r006-bb98706c-2f56-48cc-8142-9606e050e7fb"
        id                        = "r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b"
        name                      = "pf-itops-vpc"
        resource_controller_url   = "https://cloud.ibm.com/vpc-ext/network/vpcs"
        resource_crn              = "crn:v1:bluemix:public:is:us-south:a/a3c1da9c4e4a4cdaaa92d1edeb7f4868::vpc:r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b"
        resource_group            = "fef8a58a10a945819e5d0a4027ebdb39"
        resource_group_name       = "Training"
        resource_name             = "pf-itops-vpc"
        resource_status           = "available"
        status                    = "available"
      ~ tags                      = [
          + "entity:pf-it-ops",
          + "env:dev",
        ]
    }

  # ibm_is_vpc_route.private_sub will be created
  + resource "ibm_is_vpc_route" "private_sub" {
      + destination = "0.0.0.0/0"
      + id          = (known after apply)
      + name        = "pf-itops-route-private"
      + next_hop    = "10.240.0.4"
      + status      = (known after apply)
      + vpc         = "r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b"
      + zone        = "us-south-1"
    }

Plan: 2 to add, 1 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.

```

`terraform apply`


```bash

λ terraform apply
data.ibm_resource_group.Training: Refreshing state...
ibm_is_ssh_key.ssh_Key: Refreshing state... [id=r006-c3418715-ac2d-4335-a172-8002a9cefc93]
ibm_is_vpc.PF_ITOPS_vpc: Refreshing state... [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b]
ibm_is_security_group.private: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce]
ibm_is_subnet.private: Refreshing state... [id=0717-9e32e51b-49f9-4fa2-a868-41129fb0a459]
ibm_is_subnet.public: Refreshing state... [id=0717-0f0193d3-a55a-4e04-91a4-bcf526ade497]
ibm_is_security_group.public: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2]
ibm_is_security_group_rule.private_sg_rule_all_out: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce.r006-f612bc01-e0ce-4d7e-91e4-7eb8c8701c04]
ibm_is_instance.private_instance: Refreshing state... [id=0717_09dd6617-6b6e-4998-800e-7e1589618d2b]
ibm_is_security_group_rule.private_sg_rule_all_in_from_public_subnet: Refreshing state... [id=r006-55eeecb6-e051-4a9c-b088-998e2012f3ce.r006-2b2d1901-b719-411d-abf9-f58fe30d334c]
ibm_is_security_group_rule.public_sg_rule_all_in_from_school: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-777e6ff8-c3fb-4392-ba2c-fb46f8a7b2cc]
ibm_is_security_group_rule.public_sg_rule_all_in_from_unicity: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-08e6e54b-9c5e-4f93-839b-2df04b6a67f4]
ibm_is_security_group_rule.public_sg_rule_all_out: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-6e07925e-5bc5-4dae-b38a-21be1cbb910c]
ibm_is_security_group_rule.public_sg_rule_all_in_from_home: Refreshing state... [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-2640a8a2-c85c-4beb-be62-938657bd43ac]
ibm_is_instance.nat_gwt_instance: Refreshing state... [id=0717_aae1e1ab-5be5-44c4-b62d-e0780a4bae2e]
ibm_is_vpc_route.private_sub: Refreshing state... [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b/r006-2ab224e1-f22e-4741-8f0a-549586b6c209]
ibm_is_floating_ip.nat_gwt_instance_floating_ip: Refreshing state... [id=r006-91d4b15b-13e1-4b05-92e5-43e5587a77a9]

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create
  ~ update in-place

Terraform will perform the following actions:

  # ibm_is_security_group_rule.public_sg_rule_all_in_from_private_subnet will be created
  + resource "ibm_is_security_group_rule" "public_sg_rule_all_in_from_private_subnet" {
      + direction  = "inbound"
      + group      = "r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2"
      + id         = (known after apply)
      + ip_version = "ipv4"
      + remote     = "10.240.0.8/29"
      + rule_id    = (known after apply)
    }

  # ibm_is_vpc.PF_ITOPS_vpc will be updated in-place
  ~ resource "ibm_is_vpc" "PF_ITOPS_vpc" {
        address_prefix_management = "auto"
        classic_access            = false
        default_network_acl       = "r006-c73f7515-20f1-42a1-a938-91451cea60d8"
        default_security_group    = "r006-bb98706c-2f56-48cc-8142-9606e050e7fb"
        id                        = "r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b"
        name                      = "pf-itops-vpc"
        resource_controller_url   = "https://cloud.ibm.com/vpc-ext/network/vpcs"
        resource_crn              = "crn:v1:bluemix:public:is:us-south:a/a3c1da9c4e4a4cdaaa92d1edeb7f4868::vpc:r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b"
        resource_group            = "fef8a58a10a945819e5d0a4027ebdb39"
        resource_group_name       = "Training"
        resource_name             = "pf-itops-vpc"
        resource_status           = "available"
        status                    = "available"
      ~ tags                      = [
          + "entity:pf-it-ops",
          + "env:dev",
        ]
    }

  # ibm_is_vpc_route.private_sub will be created
  + resource "ibm_is_vpc_route" "private_sub" {
      + destination = "0.0.0.0/0"
      + id          = (known after apply)
      + name        = "pf-itops-route-private"
      + next_hop    = "10.240.0.4"
      + status      = (known after apply)
      + vpc         = "r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b"
      + zone        = "us-south-1"
    }

Plan: 2 to add, 1 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

ibm_is_security_group_rule.public_sg_rule_all_in_from_private_subnet: Creating...
ibm_is_vpc.PF_ITOPS_vpc: Modifying... [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b]
ibm_is_security_group_rule.public_sg_rule_all_in_from_private_subnet: Creation complete after 2s [id=r006-e0b70804-3ca3-4b4c-9e12-6e106253aff2.r006-2dc7fba3-f6df-4b16-9022-224d509408d8]
ibm_is_vpc.PF_ITOPS_vpc: Modifications complete after 2s [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b]
ibm_is_vpc_route.private_sub: Creating...
ibm_is_vpc_route.private_sub: Still creating... [10s elapsed]
ibm_is_vpc_route.private_sub: Creation complete after 11s [id=r006-d051f0a3-812e-4aaa-8b5b-c5d271fb7b8b/r006-3a99fe43-0fc7-48e8-8c4b-72be2c496c15]

Apply complete! Resources: 2 added, 1 changed, 0 destroyed.

Outputs:

ngwt-instance = 52.116.128.53
private-instance = 10.240.0.12
private_sub-ipv4_cidr_block = 10.240.0.8/29
public_sub-ipv4_cidr_block = 10.240.0.0/29

```

```bash

λ tssh -J ubuntu@52.116.128.53 ubuntu@10.240.0.12
Enter passphrase for key '/c/Users/rufol/.ssh/id_rsa':
Enter passphrase for key '/c/Users/rufol/.ssh/id_rsa':
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-66-generic ppc64le)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Feb 13 02:16:47 CST 2020

  System load:  0.16              Processes:             112
  Usage of /:   2.2% of 97.92GB   Users logged in:       0
  Memory usage: 9%                IP address for enp0s1: 10.240.0.12
  Swap usage:   0%


102 packages can be updated.
0 updates are security updates.

Failed to connect to https://changelogs.ubuntu.com/meta-release-lts. Check your Internet connection or proxy settings


Last login: Thu Feb 13 01:58:45 2020 from 10.240.0.4
ubuntu@pf-itops-private:~$ ping 10.240.0.4
PING 10.240.0.4 (10.240.0.4) 56(84) bytes of data.
64 bytes from 10.240.0.4: icmp_seq=1 ttl=64 time=3.01 ms
64 bytes from 10.240.0.4: icmp_seq=2 ttl=64 time=3.08 ms
64 bytes from 10.240.0.4: icmp_seq=3 ttl=64 time=4.97 ms

--- 10.240.0.4 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2002ms
rtt min/avg/max/mdev = 3.015/3.692/4.977/0.911 ms
ubuntu@pf-itops-private:~$

```


## Cons about the IBM Cloud Terraform Plugin
- You can't use the ibmcloud cli credentials

## Workaround for resource group
https://ibm-cloud.github.io/tf-ibm-docs/v1.2.0/d/resource_group.html

DO NOT SELECT the default resource group

## Documentation about IBM Cloud terraform ressources and data
https://ibm-cloud.github.io/tf-ibm-docs/v1.2.0

## ibm_is_vpc
https://ibm-cloud.github.io/tf-ibm-docs/v1.2.0/d/is_vpc.html

### Pro
- Can set the name of the VPC

### cons
- Can't add tags to the IBM ressource (not documented)
- The VPC Name has to follow some typo (eg, start with a lower letter)

```bash
Error: {"errors":[{"code":"bad_field","message":"Invalid json payload provided","target":{"name":"vpcs.vpcs.name","type":"field"}}],"trace":"b7a252bb-0a4e-4758-9995-afe30193ae7b"}
```

## ibm_is_ssh_key
https://ibm-cloud.github.io/tf-ibm-docs/v1.2.0/d/is_ssh_key.html

This ressource works !

