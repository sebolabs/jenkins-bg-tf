module "jenkins_blue" {
  source = "github.com/sebolabs/microservice-tf.git"

  name        = "${var.module}-b"
  project     = "${var.project}"
  environment = "${var.environment}"
  component   = "${var.component}"

  vpc_id               = "${var.vpc_id}"
  availability_zones   = "${slice(var.availability_zones, 0, length(var.availability_zones))}"
  subnets_cidrs        = "${var.jenkins_blue_subnet_cidrs}"
  subnets_route_tables = ["${var.private_route_table_ids}"]

  lc_ami_id        = "${var.lc_ami_id}"
  lc_instance_type = "${var.lc_instance_type}"
  lc_spot_price    = "${var.lc_blue_spot_price}"
  lc_user_data     = "${data.template_cloudinit_config.jenkins_blue.rendered}"
  lc_key_name      = "${var.lc_key_name}"

  lc_additional_sg_ids = [
    "${var.lc_additional_sg_ids}",
    "${aws_security_group.jenkins.id}",
  ]

  asg_size_min               = 0
  asg_size_desired_on_create = "${var.jenkins_blue_nodes_number}"
  asg_size_max               = 1
  asg_load_balancers         = ["${var.jenkins_bg_active == "blue" ? aws_elb.jenkins.name : "" }"]

  default_tags = "${var.default_tags}"
}

module "jenkins_green" {
  source = "github.com/sebolabs/microservice-tf.git"

  name        = "${var.module}-g"
  project     = "${var.project}"
  environment = "${var.environment}"
  component   = "${var.component}"

  vpc_id               = "${var.vpc_id}"
  availability_zones   = "${slice(var.availability_zones, 1, length(var.availability_zones))}"
  subnets_cidrs        = "${var.jenkins_green_subnet_cidrs}"
  subnets_route_tables = ["${var.private_route_table_ids}"]

  lc_ami_id        = "${var.lc_ami_id}"
  lc_instance_type = "${var.lc_instance_type}"
  lc_spot_price    = "${var.lc_green_spot_price}"
  lc_user_data     = "${data.template_cloudinit_config.jenkins_green.rendered}"
  lc_key_name      = "${var.lc_key_name}"

  lc_additional_sg_ids = [
    "${var.lc_additional_sg_ids}",
    "${aws_security_group.jenkins.id}",
  ]

  asg_size_min               = 0
  asg_size_desired_on_create = "${var.jenkins_green_nodes_number}"
  asg_size_max               = 1
  asg_load_balancers         = ["${var.jenkins_bg_active == "green" ? aws_elb.jenkins.name : "" }"]

  default_tags = "${var.default_tags}"
}
