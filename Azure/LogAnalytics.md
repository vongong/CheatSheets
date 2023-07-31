
## Azure Log Analytics Workspace
Log Analytics Workspace is Azure Resource

Think of Log Analytics Workspace as a container for logs

Az Resource can send to one or many Log Analytics workpaces

arm microsoft.operationalinsights/workspaces
  properties
    "retentionInDays": 30
    
Sku