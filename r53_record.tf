resource "aws_route53_record" "jenkins" {
  name    = "${var.r53_record_name}"
  zone_id = "${var.hosted_zone_id}"
  type    = "A"

  alias {
    name                   = "${aws_elb.jenkins.dns_name}"
    zone_id                = "${aws_elb.jenkins.zone_id}"
    evaluate_target_health = true
  }
}
