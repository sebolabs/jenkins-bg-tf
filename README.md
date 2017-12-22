# jenkins-bg-tf

**Info**
------
This Terraform module creates a range of resources to deliver a fully functional Jenkins Master infrastructure with some of the Blue/Green capabilities, all based on my professional Jenkins usage experience.

**Story**
------
[Jenkins HA in AWS — a proven architecture](https://medium.com/@sebolabs/jenkins-ha-aws-cd55d82057c8)

**Usage**
------
```python
module "jenkins" {
  source = "github.com/sebolabs/jenkins-bg-tf.git"

  project     = "lab"
  environment = "test"
  component   = "mgmt"

  vpc_id             = "vpc-XXXXXXX"
  availability_zones = "${data.aws_availability_zones.available.names}"
  hosted_zone_id     = "XXXXXXXXXXX"
  domain_name        = "test.lab.aws"

  private_route_table_ids = ["rtb-XXXXXXX"]
  lc_instance_type        = "m3.medium"
  lc_ami_id               = "ami-ebd02392"
  lc_key_name             = "my-lab-key-name"

  ebs_volume_size = 10
  
  jenkins_blue_version       = "2.73.1-1.1"
  jenkins_green_version      = "latest"
  jenkins_blue_subnet_cidrs  = ["10.1.0.0/28"]
  jenkins_green_subnet_cidrs = ["10.1.0.16/28"]

  elb_subnets_cidrs = [
    "10.1.0.32/28",
    "10.1.0.48/28",
  ]
}
```

**OS Support**
------
Supported operating systems:
1. RedHat 6
2. CentOS 6
3. Amazon Linux

**Terraform compatibility**
------
TF versions tested: 0.9.11, 0.10.7

**Dependencies**
------
1. microservice-tf
2. subnets-tf
