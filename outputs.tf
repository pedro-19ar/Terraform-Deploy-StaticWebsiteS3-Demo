output "website_url" {
  description = "URL pública del sitio"
  value       = module.s3_static_website.website_url
}