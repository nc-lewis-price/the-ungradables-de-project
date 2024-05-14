resource "aws_s3_bucket" "remote-state-bucket" {
  bucket = "nc-ungradables-remote-state"
  tags = {
    Name    = "ungradables"
    Project = "totesys"
  }
}
