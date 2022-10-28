resource "aws_instance" "windows" {
  
  ami         = "ami-050d0a1abe93f4773"
  instance_type = "t3.small"
  associate_public_ip_address = true
  key_name                    = aws_key_pair.pskey.key_name
  security_groups    = [aws_security_group.winsec.id]
  subnet_id                   = aws_subnet.main.id
 iam_instance_profile = "${aws_iam_instance_profile.ec2_profile.name}"

tags = {
  key = "windows-AD"
}
}