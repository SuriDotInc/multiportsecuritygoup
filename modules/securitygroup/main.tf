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
        security_groups = var.access_from_sg
      }
    ]

    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      description = ingress.value.description
      security_groups = [var.access_from_sg]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

resource "aws_security_group_rule" "multi_securitygroup_rule" {
  for_each = {for sec_rule in var.multi_port_sg2: sec_rule.from_port => sec_rule }
  type = "ingress"
  from_port = each.value.from_port
  to_port = each.value.to_port
  protocol = each.value.protocol
  description = each.value.description
  cidr_blocks = compact(tolist(each.value.cidr_blocks[*]))
  security_group_id = aws_security_group.multi_securitygroup.id
  }
  
  
  
  
  
