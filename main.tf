resource "aws_instance" "web" {
  ami           = "ami-08d8ac128e0a1b91c"
  instance_type = "t2.micro"

  tags = {
    Name = "linuserver"clear
  }
 }
 module "endpoints"{
  source = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"

  vpc_id             = "vpc-12345678"
  security_group_ids = ["sg-12345678"]

  endpoints = {
    s3 = {
      # interface endpoint
      service             = "s3"
      tags                = { Name = "s3-vpc-endpoint" }
    },
    dynamodb = {
      # gateway endpoint
      service         = "dynamodb"
      route_table_ids = ["rt-12322456", "rt-43433343", "rt-11223344"]
      tags            = { Name = "dynamodb-vpc-endpoint" }
    },
    sns = {
      service    = "sns"
      subnet_ids = ["subnet-12345678", "subnet-87654321"]
      tags       = { Name = "sns-vpc-endpoint" }
    },
    sqs = {
      service             = "sqs"
      private_dns_enabled = true
      security_group_ids  = ["sg-987654321"]
      subnet_ids          = ["subnet-12345678", "subnet-87654321"]
      tags                = { Name = "sqs-vpc-endpoint" }
    },
  }

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}