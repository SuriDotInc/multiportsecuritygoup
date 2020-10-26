locals {

  common_sg_ec2 = "sg-000099999ec2"
  envspecific_tags = {
    "TestEnvironment" = "dev"
    "TestFunction"    = "API"
  }

  common_tags = {
    "ID"        = "BalBla"
    "POC"       = "BalBla"
    "System"    = "BalBla"
    "managedby" = "BalBla"
  }

  ingress_values = [
    {
      from_port   = "80",
      to_port     = "80",
      protocol    = "TCP",
      description = "Allow TCP from port 80 "
    },
    {
      from_port   = "135",
      to_port     = "139",
      protocol    = "UDP",
      description = "Allow UDP from ports 135 - 139"
    },
  ]
  ingress_values_with_cidr = [
    {
      from_port   = "80",
      to_port     = "80",
      protocol    = "TCP",
      description = "Allow TCP from port 80 ",
      cidr_blocks = "0.0.0.0/0"
    },
    {
      from_port   = "135",
      to_port     = "139",
      protocol    = "UDP",
      description = "Allow UDP from ports 135 - 139",
      cidr_blocks = "0.0.0.0/0"
    },
  ]
}

module "mysecuritygroup" {
  source        = "./modules/securitygroup"
  sgname        = "my-bla-bla-$(lower(terraform.workspace))-sg"
  description   = "Bla Bla Security Group"
  vpc_id        = "vpc-xxxx"
  multi_port_sg = local.ingress_values
  multi_port_sg2 = local.ingress_values_with_cidr
  tags = "${merge(local.common_tags, local.envspecific_tags,
    map(
      "Type", "Test-Securitygroup",
      "Name", "BlaBlaTest"
    )
  )}"
}

module "instnaceprovision" {
  source                 = "....XXXX"
  image_id               = "XXXX"
  vpc_security_group_ids = concat(local.common_sg_ec2, tolist(["$module.mysecuritygroup.mutiportsecurityid"]))
  #.... Use your custom code for provision.
}
