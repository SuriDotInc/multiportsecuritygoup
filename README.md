# Multi Port Security Group
The security module can be used for provision security group with multiple ports and multiple protocols and cidr blocks.

All you need to pass required variables and most importantly ingress_values with list(map(string)) type. You can use another variable file or you can pass all variables as local from main.tf.
