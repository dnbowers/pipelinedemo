resource "azurerm_monitor_action_group" "backupfailures" {
  name                = var.action_group_full_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_short_name

  email_receiver {
    name          = var.receiver_name
    email_address = var.receiver_email_address  
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "backupfailures" {
  name                = var.alert_name 
  location            = var.region
  resource_group_name = data.azurerm_resource_group.res_grp.name

  action {
    action_group           = [azurerm_monitor_action_group.backupfailures.id]
  }
  data_source_id = data.azurerm_log_analytics_workspace.log_ws.id
  description    = "Alert when total results cross threshold"
  enabled        = true
  # Count all requests with server error result code grouped into 5-minute bins
  # Backup Success Query
  query       = <<-QUERY
  AddonAzureBackupJobs
    | where JobOperation=="Backup"
    | summarize arg_max(TimeGenerated,*) by JobUniqueId
    | where JobStatus=="Completed"
  QUERY
  
  # Backup Failed Query
  /*
  query       = <<-QUERY
  AddonAzureBackupJobs
    | where JobOperation=="Backup"
    | summarize arg_max(TimeGenerated,*) by JobUniqueId
    | where JobStatus=="Failed"  
  QUERY
  */

  severity    = 3
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}