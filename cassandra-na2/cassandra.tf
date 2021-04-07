provider "aws" {
  region                  = "us-east-1"
}

resource "aws_instance" "cassandra" {

  ami                    = "ami-023935cef4f385f2d"
  instance_type          = "m4.2xlarge"
  availability_zone      = "us-east-1a"
  key_name               = "prodna2"
  subnet_id              = "subnet-0efef13112d26b5be"
  vpc_security_group_ids = ["sg-057f6b2f26a821e13", "sg-01f09cbb57c87386b", "sg-0099cecdcb939611f"]
  iam_instance_profile   = "cloudwatchagentadminrole"
  user_data              = "${base64encode(file("cassandraudna2.sh"))}"



  tags = {
    Name = "ProdNa2-Cassandra"
  }
}
resource "aws_ebs_volume" "commit-log" {
  availability_zone = "us-east-1a"
  size              = 40
}
resource "aws_volume_attachment" "commit-dir-vol" {
  device_name = "/dev/sdb"
  volume_id   = "${aws_ebs_volume.commit-log.id}"
  instance_id = "${aws_instance.cassandra.id}"
}
resource "aws_ebs_volume" "data-dir" {
  availability_zone = "us-east-1a"
  size              = 1024
}
resource "aws_volume_attachment" "data-dir-vol" {
  device_name = "/dev/sdc"
  volume_id   = "${aws_ebs_volume.data-dir.id}"
  instance_id = "${aws_instance.cassandra.id}"
}
