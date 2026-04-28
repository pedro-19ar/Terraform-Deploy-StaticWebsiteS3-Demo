# Llamado al módulo reutilizable
module "s3_static_website" {
  source = "./modules/s3_static_website"

  bucket_name = var.bucket_name #Nombre del bucket que se llama desde la variable global
  owner       = var.owner       #Lo mismo para el propietario del proyecto que se llama desde la variable global
}