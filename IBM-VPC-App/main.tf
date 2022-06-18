terraform {
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "~> 1.33.0"
    }
  }
}



provider "ibm" {
  # ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.vpc_region
  ibmcloud_timeout = 60
}

locals {
  ZONE1 = "${var.vpc_region}-1"
  #ZONE2 = "${var.vpc_region}-2"
  subnet_ids = tolist([ibm_is_subnet.subnet1.id])
  vsi_count  = var.vsi_per_subnet * length(local.subnet_ids)
}

resource "random_id" "name1" {
  byte_length = 4
}

data "ibm_is_image" "image" {
  name = var.image
}

resource "ibm_is_ssh_key" "ssh_key" {
  name       = "${var.unique_id}-ssh-key-${random_id.name1.hex}"
  public_key = var.ssh_public_key
}

resource "ibm_is_vpc" "vpc1" {
  name           = "vpc-${var.vpc_region}-${random_id.name1.hex}-app"
  resource_group = var.resource_group_id
}

output "app_url" {
  description = "blueprint app url"
  value       = "http://${ibm_is_floating_ip.vsi_fip[0].address}/"
}

resource "ibm_is_public_gateway" "public_gateway1" {
  name = "public-gateway-${var.vpc_region}-${random_id.name1.hex}"
  vpc  = ibm_is_vpc.vpc1.id
  zone = local.ZONE1

  //User can configure timeouts
  timeouts {
    create = "90m"
  }
}

resource "ibm_is_subnet" "subnet1" {
  name                     = "subnet-${random_id.name1.hex}"
  vpc                      = ibm_is_vpc.vpc1.id
  resource_group           = var.resource_group_id
  zone                     = local.ZONE1
  total_ipv4_address_count = 256
  public_gateway           = ibm_is_public_gateway.public_gateway1.id
}

resource "ibm_is_security_group" "http" {
  name           = "${var.unique_id}-http-${random_id.name1.hex}"
  resource_group = var.resource_group_id
  vpc            = ibm_is_vpc.vpc1.id
}

# Allow ingress for http access to website
resource "ibm_is_security_group_rule" "httpingress" {
  direction = "inbound"
  group     = ibm_is_security_group.http.id
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 80
    port_max = 80
  }
}

resource "ibm_is_security_group" "allow_all" {
  name           = "${var.unique_id}-allow-all-${random_id.name1.hex}"
  resource_group = var.resource_group_id
  vpc            = ibm_is_vpc.vpc1.id
}

# resource "ibm_is_security_group_rule" "ingress" {
#   direction = "inbound"
#   group     = ibm_is_security_group.allow_all.id
#   remote    = "0.0.0.0/0"
# }

# Allow egress for software install 
resource "ibm_is_security_group_rule" "egress" {
  direction = "outbound"
  group     = ibm_is_security_group.allow_all.id
  remote    = "0.0.0.0/0"
}



resource "ibm_is_instance" "vsi" {
  count          = local.vsi_count
  name           = "${var.unique_id}-vsi-${count.index + 1}-${random_id.name1.hex}"
  image          = data.ibm_is_image.image.id
  profile        = var.machine_type
  resource_group = var.resource_group_id

  primary_network_interface {
    subnet = element(local.subnet_ids, floor(count.index / var.vsi_per_subnet))
    security_groups = [
      ibm_is_security_group.allow_all.id,
      ibm_is_security_group.http.id
    ]
  }

  user_data = file("${path.module}/config/ubuntu_install_nginx.sh")

  vpc = ibm_is_vpc.vpc1.id
  zone = element(
    tolist([local.ZONE1]),
    index(
      local.subnet_ids,
      element(local.subnet_ids, floor(count.index / var.vsi_per_subnet))
    )
  )

  keys = tolist([ibm_is_ssh_key.ssh_key.id])
  #volumes    = length(var.volumes) > 0 ? module.volumes.ids[count.index] : null
}

##############################################################################


##############################################################################
# Provision Floating IPs for Subnets
##############################################################################

resource "ibm_is_floating_ip" "vsi_fip" {
  count  = var.enable_fip ? var.vsi_per_subnet * length(local.subnet_ids) : 0
  name   = "${var.unique_id}-fip-${count.index + 1}-${random_id.name1.hex}"
  target = element(ibm_is_instance.vsi.*.primary_network_interface.0.id, count.index)
}

##############################################################################
