# Create 2 S3 buckets with same resource block
# Names: terraform-session-aug2025-yourname-1, terraform-session-aug2025-yourname-2
# object_lock_enabled = true, object_lock_enabled = false
# acl: private, acl: public-read
# Tag: bucket-1, Name = bucket-2

resource "aws_s3_bucket" "example" {
  for_each            = var.buckets
  bucket              = each.value.name
  object_lock_enabled = each.value.object_lock_enabled
  acl                 = null
  tags = {
    Name = each.key

  }
}


# Input Variables is to configure resources.
variable "buckets" {
  description = "This map is for buckets"
  type        = map(any)
  default = {
    bucket-1 = {
      name                = "terraform-session-aug2025-sun-1",
      object_lock_enabled = true,
      acl                 = "private"
    },
    bucket-2 = {
      name                = "terraform-session-aug2025-sun-2",
      object_lock_enabled = false,
      acl                 = "public-read"
    }
  }
}