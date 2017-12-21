output "jenkins_sg_id" {
  value = "${aws_security_group.jenkins.id}"
}

output "jenkins_blue_iam_role_name" {
  value = "${module.jenkins_blue.iam_role_name}"
}

output "jenkins_blue_asg_id" {
  value = "${module.jenkins_blue.autoscaling_group_id}"
}

output "jenkins_blue_asg_name" {
  value = "${module.jenkins_blue.autoscaling_group_name}"
}

output "jenkins_green_iam_role_name" {
  value = "${module.jenkins_blue.iam_role_name}"
}

output "elb_sg_id" {
  value = "${aws_security_group.elb.id}"
}

output "elb_fqdn" {
  value = "${aws_route53_record.jenkins.fqdn}"
}

output "ebs_volume_id" {
  value = "${aws_ebs_volume.jenkins.id}"
}
