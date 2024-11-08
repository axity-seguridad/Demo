terraform {
	backend "s3" {
	  bucket = "iac-axity"
	  key    = "servidor/terraform.tfstate"
	  region = "eu-west-1"
	  dynamodb_table = "terraform-infraestructura-como-codigo-locks"
	  encrypt        = true
	}
  }

  provider "aws" {
  	region     = "eu-west-1"
  }
  resource "aws_kms_key" "mykey" {
	  description             = "This key is used to encrypt bucket objects"
	  deletion_window_in_days = 10
	  enable_key_rotation = true
	}
  resource "aws_s3_bucket" "terraform_state" {
	bucket = "iac-axity"
  
	lifecycle {
	  prevent_destroy = true
	}  
  }
  
  resource "aws_s3_bucket_server_side_encryption_configuration" "encryption-bucket-terraform_state" {
	  bucket = aws_s3_bucket.terraform_state.id
	  rule {
		apply_server_side_encryption_by_default {
		  sse_algorithm = "AES256"
		}
	  }
	}
  resource "aws_s3_bucket_versioning" "bucket_versioning" {
		bucket = aws_s3_bucket.terraform_state.id
		
  	}
  
  
  resource "aws_s3_bucket_logging" "terraform_state_logging" {
	  bucket = aws_s3_bucket.terraform_state.id
	  target_bucket = aws_s3_bucket.terraform_state.id
	  target_prefix = "log/"
	}
  resource "aws_dynamodb_table" "terraform_locks" {
	name         = "terraform-infraestructura-como-codigo-locks"
	billing_mode = "PAY_PER_REQUEST"
	hash_key     = "LockID"
    
	attribute {
	  name = "LockID"
	  type = "S"
	}
	point_in_time_recovery {
    enabled = true
  	}
	server_side_encryption {
    enabled = true
	kms_key_arn = aws_kms_key.mykey.arn
  	}
  }
  
