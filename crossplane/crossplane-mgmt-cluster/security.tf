resource "aws_security_group" "cluster_sg" {
    name = "control_plane_mgmt_cluster_sg"
    description = "cluster sg"
    vpc_id = var.vpc_id

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group_rule" "cluster_sg_ingress_rule" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.cluster_sg.id
}