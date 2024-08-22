# LOCALS

locals {
  tags = {
    CreatedBy = var.createdby
    Deadline  = var.deadline
    Owner     = var.owner
    Pod       = var.pod
    Project   = var.project
  }
}

# Create a Resource Group
resource "azurerm_resource_group" "resource_group" {
    name     = "rg-webapp-demo"
    location = "eastus"
    
    tags = local.tags
}

# Create a Storage Account
resource "azurerm_storage_account" "storage_account" {
    name                     = "stgwebappdemo"
    resource_group_name      = azurerm_resource_group.resource_group.name
    location                 = azurerm_resource_group.resource_group.location
    account_tier              = "Standard"
    account_replication_type = "LRS"
    account_kind = "StorageV2"

static_website {
    index_document = "index.html"
    }
}

# Add a index.html file
resource "azurerm_storage_blob" "blob" {
    name                   = "index.html"
    storage_account_name   = azurerm_storage_account.storage_account.name
    storage_container_name = "$web"
    type = "Block"
    content_type = "text/html"
    source_content = "<h1> Andate Altamirano! </h1>"  
}