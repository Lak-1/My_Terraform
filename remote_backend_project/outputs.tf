output "s3_bucket_name" {
  value       = aws_s3_bucket.tf_state_bucket.id
  description = "The NAME of the S3 bucket"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.tf_state_bucket.arn
  description = "The ARN of the S3 bucket"
}

output "s3_bucket_region" {
  value       = aws_s3_bucket.tf_state_bucket.region
  description = "The REGION of the S3 bucket"
}

output "dynamodb_table_name" {
  value       = aws_dynamodb_table.terraform_lock.name
  description = "The ARN of the DynamoDB table"
}

output "dynamodb_table_arn" {
  value       = aws_dynamodb_table.terraform_lock.arn
  description = "The ARN of the DynamoDB table"
}