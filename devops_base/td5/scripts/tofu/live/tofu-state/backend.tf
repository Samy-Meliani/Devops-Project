terraform {
backend "s3" {
bucket = "YOUR_S3_BUCKET_NAME" # Replace
key = "td5/scripts/tofu/live/tofu-state"
region = "us-east-2" # Your AWS region
encrypt = true
dynamodb_table = "YOUR_DYNAMODB_TABLE_NAME" # Replace
}
}