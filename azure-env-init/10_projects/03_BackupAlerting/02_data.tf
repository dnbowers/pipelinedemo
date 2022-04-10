data "azurerm_resource_group" "res_grp" {
  name = var.resource_group_name
}
data "azurerm_log_analytics_workspace" "log_ws" {
  name = var.la_workspace
  resource_group_name = var.resource_group_name
}