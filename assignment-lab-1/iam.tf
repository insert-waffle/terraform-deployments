resource "aws_iam_role" "ec2_s3_access_role" {
  name               = "s3-role"
  assume_role_policy = file("assumerolepolicy.json")
}

resource "aws_iam_policy" "s3policy" {
  name        = "s3policy"
  description = "Allows all access to S3"
  policy      = file("s3policy.json")
}

resource "aws_iam_policy_attachment" "s3-attach" {
  name       = "s3-attachment"
  roles      = ["${aws_iam_role.ec2_s3_access_role.name}"]
  policy_arn = "${aws_iam_policy.s3policy.arn}"
}

resource "aws_iam_instance_profile" "ec2-s3_profile" {
  name  = "ec2-s3_profile"
  role = aws_iam_role.ec2_s3_access_role.name
}