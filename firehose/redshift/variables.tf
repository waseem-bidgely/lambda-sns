variable "name" {
type = string
}
variable "prefix" {
  default = "string"
}
variable "password" {
  default = "string"
  sensitive = true
}
