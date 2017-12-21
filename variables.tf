variable "project" {
  type        = "string"
  description = "The project name"
}

variable "environment" {
  type        = "string"
  description = "The environment name"
}

variable "component" {
  type        = "string"
  description = "The component name"
}

variable "module" {
  type        = "string"
  description = "This module name"
  default     = "jenkins"
}

variable "name" {
  type        = "string"
  description = "A common name for resources used in this module"
  default     = "jenkins"
}

variable "default_tags" {
  type        = "map"
  description = "Default tags to apply to all taggable resources"
  default     = {}
}

variable "vpc_id" {
  type        = "string"
  description = "The VPC id"
}

variable "availability_zones" {
  type        = "list"
  description = "A list of availablity zones for subnets creation"
}

variable "lc_ami_id" {
  type        = "string"
  description = "The EC2 image ID to launch"
}

variable "lc_instance_type" {
  type        = "string"
  description = "The size of instance to launch"
}

variable "lc_key_name" {
  type        = "string"
  description = "The key name that should be used for the Jenkins instance"
  default     = ""
}

variable "lc_blue_spot_price" {
  type        = "string"
  description = "The price to use for reserving blue spot instance"
  default     = ""
}

variable "lc_green_spot_price" {
  type        = "string"
  description = "The price to use for reserving green spot instance"
  default     = ""
}

variable "lc_additional_sg_ids" {
  type        = "list"
  description = "A list of additional security groups ids to be attached to launch configurations"
  default     = []
}

variable "jenkins_bg_active" {
  type        = "string"
  description = "The current active stack used to switch the load balancer"
  default     = "blue"
}

variable "jenkins_blue_subnet_cidrs" {
  type        = "list"
  description = "A list of CIDR blocks used for blue subnets creation"
}

variable "jenkins_green_subnet_cidrs" {
  type        = "list"
  description = "A list of CIDR blocks used for green subnets creation"
}

variable "jenkins_blue_nodes_number" {
  type        = "string"
  description = "The desired size of the blue ASG *ON CREATION ONLY*"
  default     = 1
}

variable "jenkins_green_nodes_number" {
  type        = "string"
  description = "The desired size of the green ASG *ON CREATION ONLY*"
  default     = 0
}

variable "jenkins_blue_version" {
  type        = "string"
  description = "The blue Jenkins package version to be installed on boot"
}

variable "jenkins_green_version" {
  type        = "string"
  description = "The green Jenkins package version to be installed on boot"
  default     = "latest"
}

variable "private_route_table_ids" {
  type        = "list"
  description = "A list of private route tables ids for subnets association"
}

variable "elb_internal" {
  type        = "string"
  description = "If true, ELB will be an internal ELB"
  default     = true
}

variable "elb_subnets_cidrs" {
  type        = "list"
  description = "A list of CIDR blocks used for ELB subnets creation"
}

variable "elb_idle_timeout" {
  type        = "string"
  description = "The time in seconds that the connection is allowed to be idle"
  default     = 400
}

variable "elb_connection_draining" {
  type        = "string"
  description = "Boolean to enable connection draining"
  default     = true
}

variable "elb_connection_draining_timeout" {
  type        = "string"
  description = "The time in seconds to allow for connections to drain"
  default     = 30
}

variable "elb_cross_zone_load_balancing" {
  type        = "string"
  description = "Enable cross-zone load balancing"
  default     = true
}

variable "elb_port" {
  type        = "string"
  description = "The port to listen on for the load balancer"
  default     = "80"
}

variable "elb_protocol" {
  type        = "string"
  description = "The protocol to listen on. Valid values are HTTP, HTTPS, TCP, or SSL"
  default     = "HTTP"
}

variable "elb_healthy_threshold" {
  type        = "string"
  description = "The number of checks before the instance is declared health"
  default     = 3
}

variable "elb_unhealthy_threshold" {
  type        = "string"
  description = "The number of checks before the instance is declared unhealthy"
  default     = 2
}

variable "elb_healthcheck_timeout" {
  type        = "string"
  description = "The length of time before the check times out"
  default     = 10
}

variable "elb_healthcheck_interval" {
  type        = "string"
  description = "The interval between checks"
  default     = 30
}

variable "ebs_volume_type" {
  type        = "string"
  description = "The type of EBS volume"
  default     = "gp2"
}

variable "ebs_volume_size" {
  type        = "string"
  description = "The size of the drive in GiBs"
}

variable "ebs_device_name" {
  type        = "string"
  description = "The device name under which the EBS volume is attached"
  default     = "/dev/xvdj"
}

variable "hosted_zone_id" {
  type        = "string"
  description = "The ID of a hosted zone in which the ELB alias record should be created"
}

variable "domain_name" {
  type        = "string"
  description = "The domain name used for Jenkins instance hostname setup"
}

variable "r53_record_name" {
  type        = "string"
  description = "The name of the R53 alias record"
  default     = "jenkins"
}
