data "template_file" "os_config" {
  template = "${file("${path.module}/templates/cloud_init_setup.yaml.tmpl")}"

  vars {
    domain_name = "${var.domain_name}"
  }
}

data "template_file" "jenkins_blue_config" {
  template = "${file("${path.module}/templates/jenkins_blue_setup.sh.tmpl")}"

  vars {
    jenkins_blue_version = "${var.jenkins_blue_version}"
    ebs_volume_id        = "${aws_ebs_volume.jenkins.id}"
    ebs_device_name      = "${var.ebs_device_name}"
    aws_region           = "${data.aws_region.current.name}"
  }
}

data "template_file" "jenkins_green_config" {
  template = "${file("${path.module}/templates/jenkins_green_setup.sh.tmpl")}"

  vars {
    jenkins_green_version = "${var.jenkins_green_version}"
  }
}

data "template_cloudinit_config" "jenkins_blue" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.os_config.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.jenkins_blue_config.rendered}"
  }
}

data "template_cloudinit_config" "jenkins_green" {
  gzip          = true
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = "${data.template_file.os_config.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.jenkins_green_config.rendered}"
  }
}
