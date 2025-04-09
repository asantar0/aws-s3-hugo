#S3
output "s3_bucket_id" {
  description = "The name of the bucket."
  value       = aws_s3_bucket.hugo_website.id
  sensitive   = false
}

output "s3_bucket_bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
  value       = aws_s3_bucket.hugo_website.bucket_domain_name
  sensitive   = false
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in."
  value       = aws_s3_bucket.hugo_website.region
  sensitive   = false
}
