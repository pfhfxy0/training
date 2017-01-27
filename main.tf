#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-ddd57685
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-crab
#

provider "aws" {
  access_key = "${var.aws_access_key}"

  secret_key = "${var.aws_secret_key}"

  region = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami           = "ami-30217250"
  instance_type = "t2.micro"
  subnet_id     = "subnet-ddd57685"
  count         = "${var.num_webs}"

  vpc_security_group_ids = [
    "sg-29ef374e",
  ]

  tags {
    Identity = "autodesk-crab"
    Name     = "fumi ${count.index+1}/${var.num_webs}"
    Group    = "search"
  }
}

variable "aws_access_key" {
  type = "string"
}

variable "aws_secret_key" {
  type = "string"
}

variable "aws_region" {
  type    = "string"
  default = "us-west-1"
}

variable "num_webs" {
  type    = "string"
  default = "3"
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
