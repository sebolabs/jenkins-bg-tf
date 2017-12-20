# Jenkins #############################################################

resource "aws_security_group" "jenkins" {
  name        = "${var.project}-${var.environment}-${var.component}-${var.name}"
  description = "SG for ${var.project}-${var.environment}-${var.component}-${var.name}"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(
    var.default_tags,
    map(
      "Name", format(
        "%s-%s-%s/%s",
        var.project,
        var.environment,
        var.component,
        var.name
      ),
      "Module", var.module
    )
  )}"
}

resource "aws_security_group_rule" "jenkins_ingress_elb_8080" {
  description              = "Allow TCP/8080 from ELB"
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.jenkins.id}"
  source_security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "jenkins_ingress_elb_49187" {
  description              = "Allow TCP/49187 from ELB"
  type                     = "ingress"
  from_port                = 49187
  to_port                  = 49187
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.jenkins.id}"
  source_security_group_id = "${aws_security_group.elb.id}"
}

resource "aws_security_group_rule" "jenkins_egress_all_https" {
  description       = "Allow TCP/443 to Internet"
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = "${aws_security_group.jenkins.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

resource "aws_security_group_rule" "jenkins_egress_all_http" {
  description       = "Allow TCP/80 to Internet"
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.jenkins.id}"

  cidr_blocks = [
    "0.0.0.0/0",
  ]
}

# ELB #################################################################

resource "aws_security_group" "elb" {
  name        = "${var.project}-${var.environment}-${var.component}-${var.name}-elb"
  description = "SG for ${var.project}-${var.environment}-${var.component}-${var.name}-elb"
  vpc_id      = "${var.vpc_id}"

  tags = "${merge(
    var.default_tags,
    map(
      "Name", format(
        "%s-%s-%s/%s-%s",
        var.project,
        var.environment,
        var.component,
        var.name,
        "elb"
      ),
      "Module", var.module
    )
  )}"
}

resource "aws_security_group_rule" "elb_egress_jenkins_8080" {
  description              = "Allow TCP/8080 to Jenkins"
  type                     = "egress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.elb.id}"
  source_security_group_id = "${aws_security_group.jenkins.id}"
}

resource "aws_security_group_rule" "elb_egress_jenkins_49187" {
  description              = "Allow TCP/49187 to Jenkins"
  type                     = "egress"
  from_port                = 49187
  to_port                  = 49187
  protocol                 = "tcp"
  security_group_id        = "${aws_security_group.elb.id}"
  source_security_group_id = "${aws_security_group.jenkins.id}"
}
