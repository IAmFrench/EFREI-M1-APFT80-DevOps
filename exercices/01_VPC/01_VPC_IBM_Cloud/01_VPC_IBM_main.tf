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

resource "ibm_is_subnet" "public" {
  name            = "pf-itops-public"
  vpc             = ibm_is_vpc.PF_ITOPS_vpc.id
  zone            = var.zone
  total_ipv4_address_count = 8
  resource_group = data.ibm_resource_group.Training.id
  network_acl = ibm_is_vpc.PF_ITOPS_vpc.default_network_acl 
}

resource "ibm_is_subnet" "private" {
  name            = "pf-itops-private"
  vpc             = ibm_is_vpc.PF_ITOPS_vpc.id
  zone            = var.zone
  total_ipv4_address_count = 8
  resource_group = data.ibm_resource_group.Training.id
  network_acl = ibm_is_vpc.PF_ITOPS_vpc.default_network_acl 
}

resource "ibm_is_ssh_key" "ssh_Key" {
  name       = "pf-itops-apares"
  public_key = file(var.pubKeyPath)
  resource_group = data.ibm_resource_group.Training.id
}

variable "pubKeyPath" {
  type = string
}