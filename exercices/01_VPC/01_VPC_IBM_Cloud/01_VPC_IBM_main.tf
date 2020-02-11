# Select the training resource group
data "ibm_resource_group" "Training" {
  name = "Training"
}

variable "tags" {
  type = list(string)
}

# Create a VPC inside the Training resource group
resource "ibm_is_vpc" "PF_ITOPS_vpc" {
  name = "pf-itops-vpc"
  resource_group = data.ibm_resource_group.Training.id
  tags = var.tags
}

variable "zone" {
  type = string
}

resource "ibm_is_subnet" "sub_a" {
  name            = "pf-itops-sub-a"
  vpc             = ibm_is_vpc.PF_ITOPS_vpc.id
  zone            = var.zone
  ipv4_cidr_block = "192.168.0.0/24"
}