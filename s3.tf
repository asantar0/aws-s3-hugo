# Step 1 - Creating a bucket
resource "aws_s3_bucket" "hugo_website" {
  bucket = var.bucket

  tags = {
    Name        = "Hugo Website"
    Environment = "Prod"
  }
}

data "aws_s3_bucket" "data_hugo_website" {
  bucket = aws_s3_bucket.hugo_website.bucket
}

#Step 2 - Enabling bucket versioning
resource "aws_s3_bucket_versioning" "versioning_parameters" {
  bucket = aws_s3_bucket.hugo_website.id

  versioning_configuration {
    status = "Enabled"
  }
}

#Step 3 - Providing S3 bucket ACL resource
resource "aws_s3_bucket_acl" "hugo_website_acl" {
  bucket = aws_s3_bucket.hugo_website.id
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_public_access_block.frontend_public_access_block,
    aws_s3_bucket_ownership_controls.hugo_website_permissions,
  ]
}

resource "aws_s3_bucket_ownership_controls" "hugo_website_permissions" {
  bucket = aws_s3_bucket.hugo_website.id

  rule {
    #object_ownership = "BucketOwnerPreferred"
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "frontend_public_access_block" {
  bucket = aws_s3_bucket.hugo_website.id

  block_public_acls        = false
  block_public_policy      = false
  ignore_public_acls       = false
  restrict_public_buckets  = false
}

# Step 4 - Configuring CORS
resource "aws_s3_bucket_cors_configuration" "frontend_cors" {
  bucket = aws_s3_bucket.hugo_website.id

  cors_rule {
    allowed_methods = ["GET"]
    allowed_origins = ["*"]
    allowed_headers = ["*"]
  }
}


#Step 5 - Allowing public access to S3 bucket objects
resource "aws_s3_bucket_policy" "hugo_website_bucket_policy" {
  bucket = aws_s3_bucket.hugo_website.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject"
        ],
        Effect    = "Allow",
        Principal = "*",
        Resource = [
          "${aws_s3_bucket.hugo_website.arn}/*"
        ]
      }
    ]
  })

  depends_on = [
    aws_s3_bucket_public_access_block.frontend_public_access_block,
  ]
}

#Step 6 - Configuring index.html and 404.html
resource "aws_s3_bucket_website_configuration" "static_site_configuration" {
  bucket = aws_s3_bucket.hugo_website.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "404.html"
  }
}

#Step 7 - Upload files
resource "aws_s3_object" "file_upload" {
  depends_on    = [aws_s3_bucket_versioning.versioning_parameters]
  bucket        = var.bucket
 
  #Folder "resources" contains files to be uploaded to s3
  for_each      = fileset ("resources/", "**/*.*")
 
  key           = each.value
  source        = "resources/${each.value}"
  content_type  = each.value
}

