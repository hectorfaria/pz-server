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
            "arn:aws:s3:::${var.bucket_name}",
            "arn:aws:s3:::${var.bucket_name}/*"
          ]
        }
      ]
  })
}

resource "aws_iam_role" "pz-ec2-s3-role" {
  name = "pz-ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "pz-ec2-s3-role-attach" {
  role       = aws_iam_role.pz-ec2-s3-role.name
  policy_arn = aws_iam_policy.pzserver-s3-policy.arn
}
resource "aws_iam_instance_profile" "pz-profile" {
  name = "pz-profile"
  role = aws_iam_role.pz-ec2-s3-role.name
}
