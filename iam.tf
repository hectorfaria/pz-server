resource "aws_iam_policy" "pzserver-s3-policy" {
  name        = "S3-Bucket-Access-Policy"
  description = "Provides permission to access S3 from ec2"

  policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "s3:*",
            "s3-object-lambda:*"
          ],
          "Resource" : [
            "arn:aws:s3:::${var.instance_ami}",
            "arn:aws:s3:::${var.instance_ami}/*"
          ]
        }
      ]
  })
}
