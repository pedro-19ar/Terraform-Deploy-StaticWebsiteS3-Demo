# Bucket S3
resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name #Nombre del bucket controlado por la variable que se llama desde el módulo reutilizable

  tags = {
    Environment = "dev"
    Owner       = var.owner #Propietario del proyecto controlado por la variable que se llama desde el módulo reutilizable
    Project     = "Betek"
  }
}

# Hosting web
resource "aws_s3_bucket_website_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  index_document {
    suffix = "index.html" #Archivo que se mostrará como página de inicio
  }
}

# Acceso público
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Política pública
resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id

  depends_on = [aws_s3_bucket_public_access_block.this]

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

# Subida de index.html
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.this.id
  key          = "index.html"
  source       = "${path.root}/index.html"
  content_type = "text/html"

  tags = {
    Environment = "dev"
    Owner       = var.owner #Propietario del proyecto controlado por la variable que se llama desde el módulo reutilizable
    Project     = "Betek"
  }
}