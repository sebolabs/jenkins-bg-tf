module "elb_subnets" {
  source = "github.com/sebolabs/subnets-tf.git"

  name        = "${var.name}-elb"
  project     = "${var.project}"
  environment = "${var.environment}"
  component   = "${var.component}"

  vpc_id             = "${var.vpc_id}"
  availability_zones = ["${var.availability_zones}"]
  cidrs              = ["${var.elb_subnets_cidrs}"]
  route_tables       = ["${var.private_route_table_ids}"]
}
