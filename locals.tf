locals {

  type = "platform"
  rules_web = "web"
  rules_bd = "db"
  vm_web_name = "netology-develop-${local.type}-${local.rules_web}"
  vm_db_name = "netology-develop-${local.type}-${local.rules_bd}"
}