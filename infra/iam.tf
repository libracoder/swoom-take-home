resource "aws_iam_group" "devops" {
  name = "devops"
}
resource "aws_iam_group_membership" "iam_group_members" {
  name  = "devops_membership"
  group = aws_iam_group.devops.name
  users = var.devops_users
}
resource "aws_iam_policy" "bucket_policy" {
  name   = "${var.chart_name}-policy"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowListObjects",
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket"
      ],
      "Resource": "${aws_s3_bucket.charts_bucket.arn}"
    },
    {
      "Sid": "AllowObjectsFetchAndCreate",
      "Effect": "Allow",
      "Action": [
        "s3:PutObjectAcl",
        "s3:PutObject",
        "s3:GetObjectAcl",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": [
          "${aws_s3_bucket.charts_bucket.arn}",
          "${aws_s3_bucket.charts_bucket.arn}/*"
      ]
    }
  ]
}
POLICY
}
resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  group      = aws_iam_group.devops.name
  policy_arn = aws_iam_policy.bucket_policy.arn
}
