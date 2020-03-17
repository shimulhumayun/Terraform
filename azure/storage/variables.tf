variable "rg-name" {
    type    =string

}

variable "location" {
    type    =string
    default = "East US"
}

variable "storage_account_name" {
    type    = string
    default = "terraformstorage"
}

variable "container_name" {
    type    = string
    default = "containerstorage"
}


