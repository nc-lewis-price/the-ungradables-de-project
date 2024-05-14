resource "aws_s3_bucket" "remote-state-bucket" {
  bucket = "nc-ungradables-state"
  tags = {
    Name    = "ungradables"
    Project = "totesys"
  }
}