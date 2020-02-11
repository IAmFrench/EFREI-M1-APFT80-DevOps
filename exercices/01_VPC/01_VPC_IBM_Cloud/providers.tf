provider "ibm" {
  ibmcloud_api_key = var.IBM_APIKEY
}

variable "IBM_APIKEY" {
  type = string
}