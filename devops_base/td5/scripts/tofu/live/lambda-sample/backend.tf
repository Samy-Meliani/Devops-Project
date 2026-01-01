terraform {
backend "s3" {
bucket = "YOUR_S3_BUCKET_NAME" # Same bucket as above
key = "td5/scripts/tofu/live/lambda-sample" # Unique key
region = "us-east-2" # Your AWS region
encrypt = true
dynamodb_table = "YOUR_DYNAMODB_TABLE_NAME" # Same table as above
}
}
