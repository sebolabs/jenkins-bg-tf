data "aws_iam_policy_document" "jenkins" {
  statement {
    sid    = "AttachEBS"
    effect = "Allow"

    actions = [
      "ec2:AttachVolume",
      "ec2:DescribeVolumes",
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "jenkins" {
  name        = "${var.project}-${var.environment}-${var.component}-jenkins"
  description = "IAM policy for ${var.project}-${var.environment}-${var.component}-jenkins"
  policy      = "${data.aws_iam_policy_document.jenkins.json}"
}

resource "aws_iam_policy_attachment" "jenkins" {
  name       = "${var.project}-${var.environment}-${var.component}-jenkins"
  roles      = ["${module.jenkins_blue.iam_role_name}"]
  policy_arn = "${aws_iam_policy.jenkins.arn}"
}
