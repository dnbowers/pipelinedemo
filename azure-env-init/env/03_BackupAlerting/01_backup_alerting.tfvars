resource_group_name     = "cb-mgmt-rg-01"
region                  = "uksouth"
la_workspace            = "cb-log-analytics"

## Backup Success Alerting - Stage 1 Testing
action_group_full_name  = "success_alert"
action_group_short_name = "successAlert"
alert_name              = "backup-success-alert"

## Backup Failed Alerting - Stage 2
#action_group_full_name  = "failure_alert"
#action_group_short_name = "failureAlert"
#alert_name              = "backup-failure-alert"

## VF Service Desk Details

receiver_name           = "Chris Buxton"
receiver_email_address  = "cbuxton1984@gmail.com"