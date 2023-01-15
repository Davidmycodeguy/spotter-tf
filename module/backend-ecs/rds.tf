resource "aws_db_instance" "db" {
  identifier = "db"
  engine = "postgres"
  instance_class = "db.t3.micro"
  name = "mydb"
  username = "postgres"
  password = "mypassword"
  allocated_storage = 20
  storage_type = "gp2"
  vpc_security_group_ids = [aws_security_group.rds.id]
}

resource "aws_security_group" "rds" {
  name        = "rds-security-group"
  description = "Security group for RDS"
  
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_iam_role" "rds_role" {
  name = "rds_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "rds.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "rds_policy" {
  name = "rds_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "rds_attachment" {
  role = aws_iam_role.rds_role.name
  policy_arn = aws_iam_policy.rds_policy.arn
}