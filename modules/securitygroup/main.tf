resource "aws_security_group" "multi_securitygroup" {

  name        = var.sgname
  description = var.description
  vpc_id      = var.vpc_id
  tags        = var.tags

  dynamic "ingress" {

    for_each = [
      for i in var.multi_port_sg :
      {
        from_port   = i.from_port
        to_port     = i.to_port
        protocol    = i.protocol
        description = i.description
        cidr_blocks = i.cidr_blocks
      }
    ]

    content {
      from_port   = ingress.from_port
      to_port     = ingress.to_port
      protocol    = ingress.protocol
      description = ingress.description
      cidr_blocks = compact(tolist(ingress.value.cidr_blocks[*]))

    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}
