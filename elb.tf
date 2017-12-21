resource "aws_elb" "jenkins" {
  name                        = "${var.project}-${var.environment}-${var.component}-${var.name}"
  internal                    = "${var.elb_internal}"
  idle_timeout                = "${var.elb_idle_timeout}"
  connection_draining         = "${var.elb_connection_draining}"
  connection_draining_timeout = "${var.elb_connection_draining_timeout}"
  cross_zone_load_balancing   = "${var.elb_cross_zone_load_balancing}"
  security_groups             = ["${aws_security_group.elb.id}"]

  subnets = ["${module.elb_subnets.subnet_ids}"]

  listener {
    instance_port     = 8080
    instance_protocol = "HTTP"
    lb_port           = "${var.elb_port}"
    lb_protocol       = "${var.elb_protocol}"
  }

  listener {
    instance_port     = 49187
    instance_protocol = "TCP"
    lb_port           = 49187
    lb_protocol       = "TCP"
  }

  health_check {
    healthy_threshold   = "${var.elb_healthy_threshold}"
    unhealthy_threshold = "${var.elb_unhealthy_threshold}"
    timeout             = "${var.elb_healthcheck_timeout}"
    target              = "TCP:8080"
    interval            = "${var.elb_healthcheck_interval}"
  }

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
