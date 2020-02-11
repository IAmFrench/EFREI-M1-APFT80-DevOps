# Select the training resource group
data "ibm_resource_group" "Training" {
  name = "Training"
}

variable "tags" {
  type = list(string)
}

# Create a VPC inside the Training resource group
resource "ibm_is_vpc" "PF_ITOPS" {
  name = "pf-itops"
  resource_group = data.ibm_resource_group.Training.id
  tags = var.tags
}

resource "ibm_is_network_acl" "defaultACL" {
    vpc = ibm_is_vpc.PF_ITOPS.id
    name = "pf-itops-defaultACL"
    rules {
        name        = "outbound"
        action      = "allow"
        source      = "0.0.0.0/0"
        destination = "0.0.0.0/0"
        direction   = "outbound"
        icmp {
          code = 1
          type = 1
        }
    }
    rules {
        name        = "inbound"
        action      = "deny"
        source      = "0.0.0.0/0"
        destination = "0.0.0.0/0"
        direction   = "inbound"
        icmp {
          code = 1
          type = 1
        }
    }
}

